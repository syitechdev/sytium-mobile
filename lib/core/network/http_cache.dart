import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http_cache.g.dart';

/// Combien de temps une réponse reste servable hors ligne.
///
/// Au-delà, mieux vaut un écran vide qu'un solde de trésorerie vieux de trois
/// semaines présenté comme la vérité.
const kHttpCacheMaxStale = Duration(days: 7);

/// Cache disque des réponses de l'API.
///
/// Il ne sert JAMAIS à éviter un appel réseau : la politique est
/// [CachePolicy.refreshForceCache], donc chaque requête part vraiment et le
/// cache n'est lu que si elle échoue. C'est un filet pour le réseau dégradé,
/// pas une optimisation de latence — celle-ci est déjà couverte par la durée de
/// vie des providers Riverpod.
///
/// `forceCache` est indispensable : l'API renvoie `Cache-Control: no-cache,
/// private`, donc sans forçage rien ne serait jamais stocké.
class HttpCache {
  HttpCache(this._store);

  final CacheStore _store;

  /// Réponses conservées, et servies uniquement en cas d'échec réseau.
  ///
  /// 401/403 sont exclus du repli : servir une page en cache à quelqu'un dont
  /// la session vient d'être révoquée lui donnerait l'illusion d'un accès.
  CacheOptions get options => CacheOptions(
    store: _store,
    policy: CachePolicy.refreshForceCache,
    hitCacheOnErrorExcept: const [401, 403],
    maxStale: kHttpCacheMaxStale,
  );

  Interceptor get interceptor => DioCacheInterceptor(options: options);

  /// Vide le cache. À appeler à CHAQUE changement de session : les réponses
  /// sont indexées par URL, pas par utilisateur, donc sans ce nettoyage le
  /// compte suivant sur le même appareil lirait les données du précédent.
  Future<void> clear() => _store.clean();
}

/// Construit le cache dans le répertoire *cache* de l'application — et non dans
/// les documents : le système peut le purger sous pression de stockage, il est
/// exclu des sauvegardes, et rien de ce qu'il contient n'est irremplaçable.
///
/// Renvoie null si le répertoire est inaccessible : l'application doit démarrer
/// même sans cache, en perdant seulement le mode hors ligne.
Future<HttpCache?> openHttpCache() async {
  try {
    final dir = await getApplicationCacheDirectory();
    return HttpCache(FileCacheStore('${dir.path}/api_cache'));
  } catch (e, st) {
    debugPrint('Cache HTTP indisponible : $e\n$st');
    return null;
  }
}

/// Le cache ouvert au démarrage. Surchargé dans `main()` ; null quand il n'a
/// pas pu s'ouvrir, ou dans les tests, qui n'écrivent jamais sur le disque.
@Riverpod(keepAlive: true)
HttpCache? httpCache(Ref ref) => null;
