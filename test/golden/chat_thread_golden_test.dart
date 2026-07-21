import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/features/auth/domain/auth_session.dart';
import 'package:sytium_mobile/features/auth/domain/auth_user.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_capabilities.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_repository.dart';
import 'package:sytium_mobile/features/workspace/presentation/chat_thread_screen.dart';
import 'package:sytium_mobile/features/workspace/realtime/fake_workspace_realtime.dart';
import 'package:sytium_mobile/features/workspace/realtime/workspace_realtime_provider.dart';
import 'package:sytium_mobile/theme/theme.dart';

class _Auth extends AuthController {
  @override
  Future<AuthState> build() async => const Authenticated(
        AuthSession(
          user: AuthUser(id: 'me', name: 'Moi', email: 'me@x.io'),
          capabilities: MobileCapabilities.baseline(),
        ),
      );
}

const _kChannel = Conversation(
  id: 'c1',
  type: ConversationType.public,
  title: 'objectifs-hebdo',
);

/// A thread covering everything the eye must be able to tell apart at a
/// glance: day marker, author blocks, the three delivery ticks, a reply quote,
/// a system pill and a deleted message.
class _Repo implements WorkspaceRepository {
  @override
  Future<Result<MessagesPage>> messages(String channelId, {String? cursor, int limit = 50}) async =>
      Ok(MessagesPage(
        messages: [
          Message(
            id: 'm1',
            channelId: 'c1',
            authorId: 'peer',
            authorName: 'Awa Diallo',
            content: 'Bonjour, le point hebdo tient toujours à 15 h ?',
            createdAt: DateTime(2026, 6, 29, 9),
          ),
          Message(
            id: 'm2',
            channelId: 'c1',
            authorId: 'me',
            content: 'Oui, salle 2.',
            createdAt: DateTime(2026, 6, 29, 9, 1),
            deliveryState: DeliveryState.read,
          ),
          Message(
            id: 'm3',
            channelId: 'c1',
            authorId: 'me',
            content: 'J’apporte les chiffres du trimestre.',
            createdAt: DateTime(2026, 6, 29, 9, 2),
            deliveryState: DeliveryState.delivered,
          ),
          Message(
            id: 'm4',
            channelId: 'c1',
            authorId: 'system',
            content: 'Appel audio · 12 min',
            isSystem: true,
            createdAt: DateTime(2026, 6, 30, 8, 30),
          ),
          Message(
            id: 'm5',
            channelId: 'c1',
            authorId: 'peer',
            authorName: 'Awa Diallo',
            content: 'Parfait, merci !',
            createdAt: DateTime(2026, 6, 30, 8, 40),
            replyTo: const ReplyPreview(
              id: 'm3',
              content: 'J’apporte les chiffres du trimestre.',
              authorId: 'me',
            ),
          ),
          Message(
            id: 'm6',
            channelId: 'c1',
            authorId: 'peer',
            authorName: 'Awa Diallo',
            content: '',
            isDeleted: true,
            createdAt: DateTime(2026, 6, 30, 8, 41),
          ),
          Message(
            id: 'm7',
            channelId: 'c1',
            authorId: 'me',
            content: 'Je viens de l’envoyer.',
            createdAt: DateTime(2026, 6, 30, 8, 45),
            deliveryState: DeliveryState.sending,
          ),
        ],
      ));

  @override
  Future<Result<void>> markRead(String channelId) async => const Ok<void>(null);

  @override
  Future<Result<List<Conversation>>> conversations() async => const Ok([]);

  @override
  Future<Result<List<Member>>> channelMembers(String channelId) async => const Ok([]);

  @override
  Future<Result<List<Member>>> orgMembers() async => const Ok([]);

  @override
  Future<Result<List<Presence>>> presence() async => const Ok([]);

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName} not stubbed');
}

Widget _harness(ThemeData theme) => ProviderScope(
      overrides: [
        authControllerProvider.overrideWith(_Auth.new),
        workspaceRepositoryProvider.overrideWithValue(_Repo()),
        workspaceRealtimeProvider.overrideWithValue(FakeWorkspaceRealtime()),
      ],
      child: MaterialApp(
        theme: theme,
        home: const ChatThreadScreen(conversation: _kChannel, pollInterval: null),
      ),
    );

/// Phone template: the default 800x600 test surface is wider than any handset
/// and would hide a bubble overflowing on a long line.
const _kPhone = Size(390, 844);

void main() {
  setUpAll(() async => initializeDateFormatting('fr_FR'));

  setUp(() {
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        .physicalSize = _kPhone;
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        .devicePixelRatio = 1.0;
  });

  tearDown(() {
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        .resetPhysicalSize();
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
        .resetDevicePixelRatio();
  });

  testWidgets('chat thread — light', (tester) async {
    await tester.pumpWidget(_harness(AppTheme.light()));
    await tester.pump(const Duration(milliseconds: 100));
    await expectLater(
      find.byType(ChatThreadScreen),
      matchesGoldenFile('goldens/chat_thread_light.png'),
    );
  });

  testWidgets('chat thread — dark', (tester) async {
    await tester.pumpWidget(_harness(AppTheme.dark()));
    await tester.pump(const Duration(milliseconds: 100));
    await expectLater(
      find.byType(ChatThreadScreen),
      matchesGoldenFile('goldens/chat_thread_dark.png'),
    );
  });
}
