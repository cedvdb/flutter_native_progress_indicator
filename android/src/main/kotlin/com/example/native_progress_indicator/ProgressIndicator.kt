 package com.example.native_progress_indicator

 import android.content.Context
 import android.graphics.Color
 import android.view.View
 import android.widget.FrameLayout
 import com.google.android.material.progressindicator.CircularProgressIndicator
 import com.google.android.material.progressindicator.LinearProgressIndicator
 import io.flutter.plugin.platform.PlatformView


 class NativeCircularProgressIndicator(context: Context, params: Map<String?, Any?>) : IndicatorPlatformView {
     private val indicator = CircularProgressIndicator(context);
     private var view: View = FrameLayout(context).apply {
         // Ensure the layout fills its parent
         layoutParams = FrameLayout.LayoutParams(
             FrameLayout.LayoutParams.MATCH_PARENT,
             FrameLayout.LayoutParams.MATCH_PARENT
         )

         // Add the indicator and make it fill the parent and centered
         addView(indicator, FrameLayout.LayoutParams(
             FrameLayout.LayoutParams.MATCH_PARENT,
             FrameLayout.LayoutParams.MATCH_PARENT
         ).apply {
             gravity = android.view.Gravity.CENTER
         })
     }

     init {
         updateView(params)
     }

     override fun getView(): View {
         return view
     }

     override fun updateView(params: Map<String?, Any?>) {
         val value = params["value"] as? Double
         val size = (params["size"] as? Double)?.toInt() ?: 36

         val progressColor = parseColor(params["progressColor"] as Map<String, Number>)
         val trackColor = parseColor(params["trackColor"] as Map<String, Number>)
         val strokeWidth = (params["strokeWidth"] as? Double)?.toInt() ?: 4

         if (value != null) {
             indicator.progress = (value  * 100).toInt()
             indicator.isIndeterminate = false
         } else {
             indicator.isIndeterminate = true
         }
         indicator.trackThickness = (strokeWidth * indicator.context.resources.displayMetrics.density).toInt()
         indicator.trackColor = trackColor
         indicator.setIndicatorColor(progressColor)
         indicator.indicatorSize = (size * indicator.context.resources.displayMetrics.density).toInt()
     }

     override fun dispose() {}
 }

 class NativeLinearProgressIndicator(context: Context, params: Map<String?, Any?>) : IndicatorPlatformView {
     private val indicator = LinearProgressIndicator(context);
     private var view: View = FrameLayout(context).apply {
         // Ensure the layout fills its parent
         layoutParams = FrameLayout.LayoutParams(
             FrameLayout.LayoutParams.MATCH_PARENT,
             FrameLayout.LayoutParams.MATCH_PARENT
         )

         // Add the indicator and make it fill the parent and centered
         addView(indicator, FrameLayout.LayoutParams(
             FrameLayout.LayoutParams.MATCH_PARENT,
             FrameLayout.LayoutParams.MATCH_PARENT
         ).apply {
             gravity = android.view.Gravity.CENTER
         })
     }

     init {
         updateView(params)
     }

     override fun getView(): View {
         return view
     }

     override fun updateView(params: Map<String?, Any?>) {
         val value = params["value"] as? Double
         val progressColor = parseColor(params["progressColor"] as Map<String, Number>)
         val trackColor = parseColor(params["trackColor"] as Map<String, Number>)
         val height = (params["height"] as? Double)?.toInt() ?: 4

         if (value != null) {
             indicator.progress = (value  * 100).toInt()
             indicator.isIndeterminate = false
         } else {
             indicator.isIndeterminate = true
         }
         indicator.trackThickness = (height * indicator.context.resources.displayMetrics.density).toInt()
         indicator.trackColor = trackColor
         indicator.setIndicatorColor(progressColor)
     }

     override fun dispose() {}
 }

 interface IndicatorPlatformView : PlatformView {
     fun updateView(params: Map<String?, Any?>)
 }

fun parseColor(colorMap: Map<String, Number>): Int {
 val a = ((colorMap["a"]?.toDouble() ?: 0.0) * 255).toInt()
 val r = ((colorMap["r"]?.toDouble() ?: 0.0) * 255).toInt()
 val g = ((colorMap["g"]?.toDouble() ?: 0.0) * 255).toInt()
 val b = ((colorMap["b"]?.toDouble() ?: 0.0) * 255).toInt()

 // Ensure the converted values are within the 0-255 range
 require(a in 0..255 && r in 0..255 && g in 0..255 && b in 0..255) {
     "Normalized color values must be in the range 0.0-1.0"
 }

 return Color.argb(a, r, g, b)
}
