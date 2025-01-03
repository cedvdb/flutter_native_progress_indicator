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
    private val circularIndicatorFactory = CircularIndicatorNativeViewFactory()
    private val linearIndicatorFactory = LinearIndicatorNativeViewFactory()
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel : MethodChannel


    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "native_progress_indicator")
        channel.setMethodCallHandler(this)

        binding
            .platformViewRegistry
            .registerViewFactory(
                "native_progress_indicator/circular",
                circularIndicatorFactory)

        binding
            .platformViewRegistry
            .registerViewFactory(
                "native_progress_indicator/linear",
                linearIndicatorFactory)
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {}

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "updateCircularIndicator" -> {
                val viewId = call.argument<Int>("viewId") ?: -1
                val params = call.argument<Map<String?, Any?>>("params")
                circularIndicatorFactory.updateView(viewId, params)
            }
            "updateLinearIndicator"-> {
                val viewId = call.argument<Int>("viewId") ?: -1
                val params = call.argument<Map<String?, Any?>>("params")
                linearIndicatorFactory.updateView(viewId, params)
            }

            else -> result.notImplemented()
        }
    }
}


class CircularIndicatorNativeViewFactory() : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    private val platformViews = mutableMapOf<Int, IndicatorPlatformView>()

    override fun create(context: Context, id: Int, args: Any?): IndicatorPlatformView {
        val platformView = NativeCircularProgressIndicator(context, args as Map<String?, Any?>)
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

class LinearIndicatorNativeViewFactory() : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    private val platformViews = mutableMapOf<Int, IndicatorPlatformView>()

    override fun create(context: Context, id: Int, args: Any?): IndicatorPlatformView {
        val platformView = NativeLinearProgressIndicator(context, args as Map<String?, Any?>)
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

