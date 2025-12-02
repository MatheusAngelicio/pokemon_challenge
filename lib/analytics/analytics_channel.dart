import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AnalyticsChannel {
  static const MethodChannel _channel = MethodChannel(
    'com.example.pokemon_challenge/analytics',
  );

  static Future<void> logEvent(
    String name,
    Map<String, dynamic> parameters,
  ) async {
    try {
      await _channel.invokeMethod('logEvent', {
        'name': name,
        'parameters': parameters,
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Erro ao logar evento no Analytics: ${e.message}');
      }
    }
  }
}
