 package com.example.native_progress_indicator

 import androidx.compose.foundation.background
 import androidx.compose.foundation.layout.Box
 import androidx.compose.foundation.layout.fillMaxSize
 import androidx.compose.foundation.layout.fillMaxWidth
 import androidx.compose.foundation.layout.height
 import androidx.compose.material3.CircularProgressIndicator
 import androidx.compose.material3.LinearProgressIndicator
 import androidx.compose.runtime.Composable
 import androidx.compose.ui.graphics.Color
 import androidx.compose.ui.graphics.StrokeCap
 import androidx.compose.ui.Modifier
 import androidx.compose.ui.unit.dp
 import com.google.android.material.progressindicator.CircularProgressIndicator



 @Composable
 fun NativeIndeterminateCircularProgressIndicator(args: Map<String, Any?>) {
     val progressColorMap = args["progressColor"] as? Map<*, *>
     val progressColor = parseColor(progressColorMap)
     val trackColorMap = args["trackColor"] as? Map<*, *>
     val trackColor = parseColor(trackColorMap)
     val strokeWidth = (args["strokeWidth"] as? Double)?.toFloat()?.dp ?: 4.dp

     val a: CircularProgressIndicator;
     a = CircularProgressIndicator()
     CircularProgressIndicator(
         color = progressColor,
         trackColor = trackColor,
         strokeCap = StrokeCap.Round,
         strokeWidth = strokeWidth
     )
 }


 @Composable
 fun NativeDeterminateCircularProgressIndicator(args: Map<String, Any?>) {
     val value = (args["value"] as? Double)?.toFloat() ?: 0.0f
     val progressColorMap = args["progressColor"] as? Map<*, *>
     val progressColor = parseColor(progressColorMap)
     val trackColorMap = args["trackColor"] as? Map<*, *>
     val trackColor = parseColor(trackColorMap)
     val strokeWidth = (args["strokeWidth"] as? Double)?.toFloat()?.dp ?: 4.dp

     CircularProgressIndicator(
         progress = value,
         color = progressColor,
         trackColor = trackColor,
         strokeCap = StrokeCap.Round,
         strokeWidth = strokeWidth
     )
 }

 @Composable
 fun NativeIndeterminateLinearProgressIndicator(args: Map<String, Any?>) {
     val progressColorMap = args["progressColor"] as? Map<*, *>
     val progressColor = parseColor(progressColorMap)
     val trackColorMap = args["trackColor"] as? Map<*, *>
     val trackColor = parseColor(trackColorMap)
     val height = (args["height"] as? Double)?.toFloat()?.dp ?: 4.dp


     Box(
         modifier = Modifier
             .fillMaxWidth()
             .height(height = height)
             .background(trackColor)

     ) {
         LinearProgressIndicator(
             color = progressColor,
             trackColor = trackColor,
             strokeCap = StrokeCap.Round,
             modifier = Modifier.fillMaxSize()
         )
     }
 }

 @Composable
 fun NativeDeterminateLinearProgressIndicator(args: Map<String, Any?>) {
     val value = (args["value"] as? Double)?.toFloat() ?: 0.0f
     val progressColorMap = args["progressColor"] as? Map<*, *>
     val progressColor = parseColor(progressColorMap)
     val trackColorMap = args["trackColor"] as? Map<*, *>
     val trackColor = parseColor(trackColorMap)
     val height = (args["height"] as? Double)?.toFloat()?.dp ?: 4.dp

     Box(
         modifier = Modifier
             .fillMaxWidth()
             .height(height = height)
             .background(trackColor)
     ) {
         LinearProgressIndicator(
             progress = value,
             color = progressColor,
             trackColor = trackColor,
             strokeCap = StrokeCap.Round,
             modifier = Modifier.fillMaxSize()
         )
     }
 }


 // Helper function to parse color maps into Color objects
 private fun parseColor(colorMap: Map<*, *>?): Color {
     if (colorMap == null) return Color.Black // Default to black if no color provided
     val r = (colorMap["r"] as? Double)?.toInt() ?: 0
     val g = (colorMap["g"] as? Double)?.toInt() ?: 0
     val b = (colorMap["b"] as? Double)?.toInt() ?: 0
     val a = (colorMap["a"] as? Double)?.toInt() ?: 255
     return Color(android.graphics.Color.argb(a, r, g, b))
 }