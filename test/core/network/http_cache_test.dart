import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/network/http_cache.dart';

/// Store en mémoire : ces tests portent sur la POLITIQUE de cache, pas sur
/// l'écriture disque.
class _RecordingStore extends MemCacheStore {
  int cleanCalls = 0;

  @override
  Future<void> clean({
    CachePriority priorityOrBelow = CachePriority.high,
    bool staleOnly = false,
  }) {
    cleanCalls++;
    return super.clean(priorityOrBelow: priorityOrBelow, staleOnly: staleOnly);
  }
}

void main() {
  test('le cache ne remplace jamais un appel réseau', () {
    final options = HttpCache(_RecordingStore()).options;

    // refreshForceCache : la requête part TOUJOURS. Le cache n'est lu qu'en
    // repli. Une politique de lecture d'abord afficherait des messages périmés
    // alors que le réseau répond.
    expect(options.policy, CachePolicy.refreshForceCache);
  });

  test('les réponses sont stockées malgré les en-têtes de l’API', () {
    // L'API renvoie `Cache-Control: no-cache, private`. Sans le forçage porté
    // par refreshForceCache, rien ne serait jamais écrit et le mode hors ligne
    // n'existerait pas.
    expect(
      HttpCache(_RecordingStore()).options.policy,
      anyOf(CachePolicy.forceCache, CachePolicy.refreshForceCache),
    );
  });

  test('une session révoquée ne se replie pas sur le cache', () {
    final options = HttpCache(_RecordingStore()).options;

    // Servir une page en cache sur 401/403 donnerait à quelqu'un dont l'accès
    // vient d'être retiré l'illusion qu'il l'a toujours.
    expect(options.hitCacheOnErrorExcept, containsAll([401, 403]));
  });

  test('les données périmées finissent par expirer', () {
    final options = HttpCache(_RecordingStore()).options;

    expect(options.maxStale, kHttpCacheMaxStale);
    expect(kHttpCacheMaxStale.inDays, lessThanOrEqualTo(7));
  });

  test('clear vide bien le store', () async {
    final store = _RecordingStore();

    await HttpCache(store).clear();

    // Appelé a chaque changement de session : les reponses sont indexees par
    // URL, donc le compte suivant lirait celles du precedent.
    expect(store.cleanCalls, 1);
  });
}
