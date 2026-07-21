import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sytium_mobile/features/workspace/application/active_chat_channel.dart';

void main() {
  ProviderContainer container() {
    final c = ProviderContainer();
    addTearDown(c.dispose);
    return c;
  }

  test('no thread is open by default', () {
    expect(container().read(activeChatChannelProvider), isNull);
  });

  test('entering then leaving a thread clears it', () {
    final c = container();
    final notifier = c.read(activeChatChannelProvider.notifier)..enter('c1');

    expect(c.read(activeChatChannelProvider), 'c1');

    notifier.leave('c1');
    expect(c.read(activeChatChannelProvider), isNull);
    // Leaving twice must not resurrect anything.
    notifier.leave('c1');
    expect(c.read(activeChatChannelProvider), isNull);
  });

  test('leaving a thread that is no longer on top changes nothing', () {
    final c = container();

    // A deep link pushed thread B on top of thread A; popping B later must not
    // blank out A, which is the one now on screen.
    c.read(activeChatChannelProvider.notifier)
      ..enter('a')
      ..enter('b')
      ..leave('a');

    expect(c.read(activeChatChannelProvider), 'b');
  });
}
