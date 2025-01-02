 package com.example.native_progress_indicator

 import android.content.Context
 import android.graphics.Color
 import android.view.View
 import android.widget.FrameLayout
 import com.google.android.material.progressindicator.CircularProgressIndicator
 import com.google.android.material.progressindicator.LinearProgressIndicator


 fun nativeCircularProgressIndicator(context: Context, args: Map<String?, Any?>): View {
     val value = (args["value"] as? Double)?.toInt()
     val size = (args["size"] as? Double)?.toInt() ?: 36

     val progressColor = parseColorFromMap(args["progressColor"] as Map<String, Number>)
     val trackColor = parseColorFromMap(args["trackColor"] as Map<String, Number>)
     val strokeWidth = (args["strokeWidth"] as? Double)?.toInt() ?: 4

     val indicator = CircularProgressIndicator(context)
     if (value != null) {
         indicator.progress = value * 100
         indicator.isIndeterminate = false
     } else {
         indicator.isIndeterminate = true
     }

     indicator.trackThickness = (strokeWidth * context.resources.displayMetrics.density).toInt()
     indicator.trackColor = trackColor
     indicator.setIndicatorColor(progressColor)
     indicator.indicatorSize = (size * context.resources.displayMetrics.density).toInt()

     val parentLayout = FrameLayout(context).apply {
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

     return parentLayout
 }

 fun nativeLinearProgressIndicator(context: Context, args: Map<String?, Any?>): View {
     val value = (args["value"] as? Double)?.toInt()
     val progressColor = parseColorFromMap(args["progressColor"] as Map<String, Number>)
     val trackColor = parseColorFromMap(args["trackColor"] as Map<String, Number>)
     val height = (args["height"] as? Double)?.toInt() ?: 4

     val indicator = LinearProgressIndicator(context)
     if (value != null) {
         indicator.progress = value * 100
         indicator.isIndeterminate = false
     } else {
         indicator.isIndeterminate = true
     }
     indicator.trackThickness = (height * context.resources.displayMetrics.density).toInt()
     indicator.trackColor = trackColor
     indicator.setIndicatorColor(progressColor)

     val parentLayout = FrameLayout(context).apply {
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

     return parentLayout }

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