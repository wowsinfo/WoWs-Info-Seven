import 'package:flutter_test/flutter_test.dart';
import 'package:wowsinfo/services/wargaming/wargaming_service.dart';

void main() {
  test('test server status', () async {
    final service = WargamingService('asia');
    final result = await service.getServerStatus();
    expect(result.hasError, false);
    expect(result.isNotEmpty, true);
    final data = result.data;
    if (data == null) {
      fail('ServerStatus should be valid');
    }
    expect(data.playersOnline, isNotNull);
    expect(data.playersOnline! > 0, isNotNull);
  });
}
