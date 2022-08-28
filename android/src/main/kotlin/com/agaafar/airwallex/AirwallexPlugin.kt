package com.agaafar.airwallex

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import com.airwallex.android.core.Environment
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** AirwallexPlugin */
class AirwallexPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var _channel : MethodChannel
  private var airwallexApi = AirwallexApi()

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    _channel = MethodChannel(flutterPluginBinding.binaryMessenger, "airwallex")
    _channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "initialize" -> result.success(airwallexApi.initialize(call.argument<Boolean>("logging")!!, call.argument<String>("environment")!!, call.argument<List<String>>("componentProvider")!!))
      "getBaseUrl" -> result.success(airwallexApi.getEnvironment())
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    _channel.setMethodCallHandler(null)
  }
}
