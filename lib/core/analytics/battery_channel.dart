import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class BatteryChannel {
  static const MethodChannel _channel = MethodChannel(
    'com.example.pokemon_challenge/battery',
  );

  static Future<int> getBatteryLevel() async {
    try {
      final int batteryLevel =
          await _channel.invokeMethod<int>('getBatteryLevel') ?? -1;
      return batteryLevel;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Erro ao obter nível da bateria: ${e.message}');
      }
      return -1;
    }
  }
}
