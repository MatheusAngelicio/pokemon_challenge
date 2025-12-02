import UIKit
import Flutter
import FirebaseCore
import FirebaseAnalytics

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    FirebaseApp.configure()

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController

    let analyticsChannel = FlutterMethodChannel(
        name: "com.example.pokemon_challenge/analytics",
        binaryMessenger: controller.binaryMessenger
    )

    analyticsChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
        switch call.method {
        case "logEvent":
            if let args = call.arguments as? [String: Any],
               let name = args["name"] as? String,
               let parameters = args["parameters"] as? [String: Any] {

                Analytics.logEvent(name, parameters: parameters)
                result(nil)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: nil, details: nil))
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    let batteryChannel = FlutterMethodChannel(
        name: "com.example.pokemon_challenge/battery",
        binaryMessenger: controller.binaryMessenger
    )

    batteryChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
        guard call.method == "getBatteryLevel" else {
            result(FlutterMethodNotImplemented)
            return
        }
        self?.receiveBatteryLevel(result: result)
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func receiveBatteryLevel(result: FlutterResult) {
    let device = UIDevice.current
    device.isBatteryMonitoringEnabled = true

    if device.batteryState == .unknown {
        result(FlutterError(code: "UNAVAILABLE",
                            message: "Battery level not available.",
                            details: nil))
    } else {
        result(Int(device.batteryLevel * 100))
    }
  }
}
