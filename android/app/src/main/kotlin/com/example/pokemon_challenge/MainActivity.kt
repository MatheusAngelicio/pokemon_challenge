package com.example.pokemon_challenge

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.google.firebase.analytics.FirebaseAnalytics

class MainActivity : FlutterActivity() {

    private val BATTERY_CHANNEL = "com.example.pokemon_challenge/battery"
    private val ANALYTICS_CHANNEL = "com.example.pokemon_challenge/analytics"
    private lateinit var firebaseAnalytics: FirebaseAnalytics

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        firebaseAnalytics = FirebaseAnalytics.getInstance(this)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BATTERY_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()
                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, ANALYTICS_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "logEvent") {
                val args = call.arguments as? Map<String, Any>
                val name = args?.get("name") as? String
                val parameters = args?.get("parameters") as? Map<String, Any>

                if (name != null) {
                    val bundle = android.os.Bundle()
                    parameters?.forEach { (key, value) ->
                        bundle.putString(key, value.toString())
                    }
                    firebaseAnalytics.logEvent(name, bundle)
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENTS", "Name is required", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(
                null,
                IntentFilter(Intent.ACTION_BATTERY_CHANGED)
            )
            batteryLevel = intent!!.getIntExtra("level", -1) * 100 /
                           intent.getIntExtra("scale", -1)
        }
        return batteryLevel
    }
}
