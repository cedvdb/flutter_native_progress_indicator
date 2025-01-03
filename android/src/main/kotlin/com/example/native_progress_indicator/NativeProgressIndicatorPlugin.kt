package com.example.native_progress_indicator


import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

/** TestPlugin */

class NativeProgressIndicatorPlugin : FlutterPlugin, MethodCallHandler {
    val _factory = NativeViewFactory();

    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        binding
            .platformViewRegistry
            .registerViewFactory(
                "native_progress_indicator/indeterminate_circular_progress_indicator",
                _factory)

        binding
            .platformViewRegistry
            .registerViewFactory(
                "native_progress_indicator/determinate_circular_progress_indicator",
                _factory)

        binding
            .platformViewRegistry
            .registerViewFactory(
                "native_progress_indicator/indeterminate_linear_progress_indicator",
                _factory)

        binding
            .platformViewRegistry
            .registerViewFactory(
                "native_progress_indicator/determinate_linear_progress_indicator",
                _factory)
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {}

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "updateParams" -> {
                val viewId = call.argument<Int>("viewId") ?: -1
                val params = call.argument<Map<String?, Any?>>("params")
                _factory.updateView(viewId, params)
            }

            else -> result.notImplemented()
    }
    }
}

enum class IndicatorType {
    Circular,
    Linear
}

class NativeViewFactory() : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    private val platformViews = mutableMapOf<Int, IndicatorPlatformView>()

    override fun create(context: Context, id: Int, args: Any?): IndicatorPlatformView {
        val type = (args as Map<String?, Any?>)["type"] as String;

        val platformView = when(type) {
            "circular" -> NativeCircularProgressIndicator(context, args as Map<String?, Any?>)
            "linear" -> NativeLinearProgressIndicator(context, args as Map<String?, Any?>)
            else -> throw UnsupportedOperationException()
        }
        platformViews[id] = platformView
        return platformView
    }

    internal fun updateView(id: Int, args: Any?) {
        val view = platformViews[id]
        view?.updateView(args as Map<String?, Any?>)
    }

    internal fun getPlatformView(id: Int): IndicatorPlatformView? {
        return platformViews[id]
    }
}
