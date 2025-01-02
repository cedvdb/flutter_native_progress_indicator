package com.example.native_progress_indicator


import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import android.view.View
import android.widget.ProgressBar

/** TestPlugin */

class NativeProgressIndicatorPlugin : FlutterPlugin {
    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        binding
            .platformViewRegistry
            .registerViewFactory("native_progress_indicator/indeterminate_circular_progress_indicator", CircularIndicatorNativeViewFactory())

        binding
            .platformViewRegistry
            .registerViewFactory("native_progress_indicator/determinate_circular_progress_indicator", CircularIndicatorNativeViewFactory())

        binding
            .platformViewRegistry
            .registerViewFactory("native_progress_indicator/indeterminate_linear_progress_indicator", LinearIndicatorNativeViewFactory())

        binding
            .platformViewRegistry
            .registerViewFactory("native_progress_indicator/determinate_linear_progress_indicator", LinearIndicatorNativeViewFactory())
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {}
}

class CircularIndicatorNativeViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        return CircularIndicatorNativeView(context, viewId, creationParams)
    }
}

class LinearIndicatorNativeViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        return LinearIndicatorNativeView(context, viewId, creationParams)
    }
}

internal class CircularIndicatorNativeView(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {
    private val indicator: View = nativeCircularProgressIndicator(context, creationParams ?: mapOf())

    override fun getView(): View {
        return indicator
    }

    override fun dispose() {}
}

internal class LinearIndicatorNativeView(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {
    private val indicator: View = nativeLinearProgressIndicator(context, creationParams ?: mapOf())

    override fun getView(): View {
        return indicator
    }

    override fun dispose() {}
}


