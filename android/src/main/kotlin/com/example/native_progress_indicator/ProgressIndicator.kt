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
         val value = (params["value"] as? Double)?.toInt()
         val size = (params["size"] as? Double)?.toInt() ?: 36

         val progressColor = parseColorFromMap(params["progressColor"] as Map<String, Number>)
         val trackColor = parseColorFromMap(params["trackColor"] as Map<String, Number>)
         val strokeWidth = (params["strokeWidth"] as? Double)?.toInt() ?: 4

         if (value != null) {
             indicator.progress = value * 100
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
         val value = (params["value"] as? Double)?.toInt()
         val progressColor = parseColorFromMap(params["progressColor"] as Map<String, Number>)
         val trackColor = parseColorFromMap(params["trackColor"] as Map<String, Number>)
         val height = (params["height"] as? Double)?.toInt() ?: 4

         if (value != null) {
             indicator.progress = value * 100
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

 fun parseColorFromMap(colorMap: Map<String, Number>): Int {
     val a = colorMap["a"]?.toInt() ?: 255 // Default alpha value if not provided
     val r = colorMap["r"]?.toInt() ?: 0   // Default red value
     val g = colorMap["g"]?.toInt() ?: 0   // Default green value
     val b = colorMap["b"]?.toInt() ?: 0   // Default blue value

     // Validate the values are within the 0-255 range
     require(a in 0..255 && r in 0..255 && g in 0..255 && b in 0..255) {
         "Color values must be in the range 0-255"
     }

     return Color.argb(a, r, g, b)
 }