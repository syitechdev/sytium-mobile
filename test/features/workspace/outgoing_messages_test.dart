import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/workspace/application/outgoing_messages.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_repository.dart';

/// Only `sendMessage` matters here; everything else throws so an accidental
/// dependency on another endpoint shows up loudly instead of silently passing.
class _SendRepo implements WorkspaceRepository {
  _SendRepo({this.fail = false});

  @override
  Future<Result<List<int>>> downloadAttachment(String url) async => const Ok(<int>[]);

  @override
  Future<Result<void>> setPinned(String messageId, {required bool pinned}) async => const Ok(null);

  @override
  Future<Result<void>> setBookmarked(String messageId, {required bool bookmarked}) async => const Ok(null);

  @override
  Future<Result<String?>> transcribeMessage(String messageId) async => const Ok(null);

  bool fail;
  final List<String> sent = [];
  final List<List<String>> attachments = [];
  final List<String?> parents = [];

  @override
  Future<Result<Message>> sendMessage(
    String channelId, {
    String content = '',
    List<String> attachmentPaths = const <String>[],
    String? parentId,
  }) async {
    if (fail) {
      return const Err(ValidationFailure(fieldErrors: {}, message: 'Fichier trop lourd.'));
    }
    sent.add(content);
    attachments.add(attachmentPaths);
    parents.add(parentId);
    return Ok(
      Message(id: 'srv-${sent.length}', channelId: channelId, authorId: 'me', content: content),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName} not stubbed');
}

ProviderContainer _container(WorkspaceRepository repo) {
  final container = ProviderContainer(
    overrides: [workspaceRepositoryProvider.overrideWithValue(repo)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  const channelId = 'c1';

  test('a queued message is visible before the server answers', () async {
    final repo = _SendRepo();
    final container = _container(repo);
    final notifier = container.read(outgoingMessagesProvider(channelId).notifier);

    final pending = notifier.send(authorId: 'me', content: 'Bonjour');

    final queued = container.read(outgoingMessagesProvider(channelId));
    expect(queued, hasLength(1));
    expect(queued.single.content, 'Bonjour');
    expect(queued.single.deliveryState, DeliveryState.sending);
    expect(queued.single.isPending, isTrue);

    await pending;
    final settled = container.read(outgoingMessagesProvider(channelId));
    expect(settled.single.id, 'srv-1');
    expect(settled.single.deliveryState, DeliveryState.sent);
  });

  test('attachments and the reply parent reach the repository', () async {
    final repo = _SendRepo();
    final container = _container(repo);
    final notifier = container.read(outgoingMessagesProvider(channelId).notifier);

    await notifier.send(
      authorId: 'me',
      content: 'Voici le doc',
      attachments: const [
        OutgoingAttachment(path: '/tmp/a.png', name: 'a.png', isImage: true),
      ],
      replyTo: const Message(
        id: 'parent-1',
        channelId: channelId,
        authorId: 'peer',
        content: 'Tu peux envoyer ?',
      ),
    );

    expect(repo.attachments.single, ['/tmp/a.png']);
    expect(repo.parents.single, 'parent-1');
  });

  test('a queued image renders from disk while it uploads', () {
    final container = _container(_SendRepo());
    unawaited(
      container.read(outgoingMessagesProvider(channelId).notifier).send(
            authorId: 'me',
            attachments: const [
              OutgoingAttachment(path: '/tmp/a.png', name: 'a.png', isImage: true),
            ],
          ),
    );

    final attachment =
        container.read(outgoingMessagesProvider(channelId)).single.attachments.single;
    expect(attachment.localPath, '/tmp/a.png');
    expect(attachment.isImage, isTrue);
    expect(attachment.url, isNull);
  });

  test('a failure keeps the message and exposes the server reason', () async {
    final repo = _SendRepo(fail: true);
    final container = _container(repo);
    final notifier = container.read(outgoingMessagesProvider(channelId).notifier);

    await notifier.send(authorId: 'me', content: 'Raté');

    final failed = container.read(outgoingMessagesProvider(channelId)).single;
    expect(failed.deliveryState, DeliveryState.failed);
    expect(failed.content, 'Raté');
    expect(notifier.failureFor(failed.id), 'Fichier trop lourd.');
  });

  test('retry re-sends and clears the failure', () async {
    final repo = _SendRepo(fail: true);
    final container = _container(repo);
    final notifier = container.read(outgoingMessagesProvider(channelId).notifier);

    await notifier.send(authorId: 'me', content: 'Raté');
    final localId = container.read(outgoingMessagesProvider(channelId)).single.id;

    repo.fail = false;
    await notifier.retry(localId);

    expect(repo.sent, ['Raté']);
    final settled = container.read(outgoingMessagesProvider(channelId)).single;
    expect(settled.deliveryState, DeliveryState.sent);
    expect(notifier.failureFor(localId), isNull);
  });

  test('retry does nothing for a message that is not failed', () async {
    final repo = _SendRepo();
    final container = _container(repo);
    final notifier = container.read(outgoingMessagesProvider(channelId).notifier);

    await notifier.send(authorId: 'me', content: 'OK');
    await notifier.retry(container.read(outgoingMessagesProvider(channelId)).single.id);

    expect(repo.sent, ['OK']); // not sent twice
  });

  test('discard drops the message', () async {
    final container = _container(_SendRepo(fail: true));
    final notifier = container.read(outgoingMessagesProvider(channelId).notifier);

    await notifier.send(authorId: 'me', content: 'À jeter');
    notifier.discard(container.read(outgoingMessagesProvider(channelId)).single.id);

    expect(container.read(outgoingMessagesProvider(channelId)), isEmpty);
  });

  test('a message discarded mid-flight does not come back', () async {
    final repo = _SendRepo();
    final container = _container(repo);
    final notifier = container.read(outgoingMessagesProvider(channelId).notifier);

    final pending = notifier.send(authorId: 'me', content: 'Annulé');
    notifier.discard(container.read(outgoingMessagesProvider(channelId)).single.id);
    await pending;

    expect(container.read(outgoingMessagesProvider(channelId)), isEmpty);
  });

  test('pruneConfirmed drops only what the server returned', () async {
    final repo = _SendRepo();
    final container = _container(repo);
    final notifier = container.read(outgoingMessagesProvider(channelId).notifier);

    await notifier.send(authorId: 'me', content: 'Un');
    await notifier.send(authorId: 'me', content: 'Deux');
    expect(container.read(outgoingMessagesProvider(channelId)), hasLength(2));

    notifier.pruneConfirmed({'srv-1'});

    final left = container.read(outgoingMessagesProvider(channelId));
    expect(left.single.id, 'srv-2');
  });

  test('each channel keeps its own queue', () async {
    final container = _container(_SendRepo(fail: true));
    await container.read(outgoingMessagesProvider('c1').notifier).send(
          authorId: 'me',
          content: 'Sur c1',
        );

    expect(container.read(outgoingMessagesProvider('c1')), hasLength(1));
    expect(container.read(outgoingMessagesProvider('c2')), isEmpty);
  });
}
