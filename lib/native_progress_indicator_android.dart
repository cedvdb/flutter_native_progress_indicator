import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:native_progress_indicator/native_progress_indicator_platform_interface.dart';

extension MapExtension on Color {
  Map<String, int> toMap() {
    return {
      'a': (a * 255).toInt(),
      'r': (r * 255).toInt(),
      'g': (g * 255).toInt(),
      'b': (b * 255).toInt(),
    };
  }
}

class NativeProgressIndicatorAndroid
    implements NativeProgressIndicatorPlatform {
  static void registerWith() {
    NativeProgressIndicatorPlatform.instance = NativeProgressIndicatorAndroid();
  }

  @override
  Widget buildDeterminateCircularProgressIndicator({
    required Color progressColor,
    required Color trackColor,
    required double strokeWidth,
    required double value,
    required double size,
  }) {
    return AndroidView(
      viewType:
          'native_progress_indicator/determinate_circular_progress_indicator',
      creationParams: {
        'progressColor': progressColor.toMap(),
        'trackColor': trackColor.toMap(),
        'strokeWidth': strokeWidth,
        'value': value,
        'size': size,
      },
      clipBehavior: Clip.none,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  @override
  Widget buildDeterminateLinearProgressIndicator({
    required Color progressColor,
    required Color trackColor,
    required double height,
    required BorderRadius borderRadius,
    required double value,
  }) {
    return AndroidView(
      viewType:
          'native_progress_indicator/determinate_linear_progress_indicator',
      creationParams: {
        'progressColor': progressColor.toMap(),
        'trackColor': trackColor.toMap(),
        'height': height,
        'value': value,
      },
      clipBehavior: Clip.none,
      layoutDirection: TextDirection.ltr,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  @override
  Widget buildIndeterminateCircularProgressIndicator({
    required Color progressColor,
    required Color trackColor,
    required double strokeWidth,
    required double size,
  }) {
    return AndroidView(
      viewType:
          'native_progress_indicator/indeterminate_circular_progress_indicator',
      creationParams: {
        'progressColor': progressColor.toMap(),
        'trackColor': trackColor.toMap(),
        'strokeWidth': strokeWidth,
        'size': size,
      },
      creationParamsCodec: const StandardMessageCodec(),
      clipBehavior: Clip.none,
    );
  }

  @override
  Widget buildIndeterminateLinearProgressIndicator({
    required Color progressColor,
    required Color trackColor,
    required double height,
    required BorderRadius borderRadius,
  }) {
    return AndroidView(
      viewType:
          'native_progress_indicator/indeterminate_linear_progress_indicator',
      creationParams: {
        'progressColor': progressColor.toMap(),
        'trackColor': trackColor.toMap(),
        'height': height
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
