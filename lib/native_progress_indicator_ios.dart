import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:native_progress_indicator/native_progress_indicator_platform_interface.dart';

class NativeProgressIndicatorIos implements NativeProgressIndicatorPlatform {
  static void registerWith() {
    NativeProgressIndicatorPlatform.instance = NativeProgressIndicatorIos();
  }

  @override
  Widget buildDeterminateCircularProgressIndicator({
    required Color progressColor,
    required Color trackColor,
    required double thickness,
    required double value,
    required double size,
  }) {
    return UiKitView(
      viewType:
          'native_progress_indicator/determinate_circular_progress_indicator',
      layoutDirection: TextDirection.ltr,
      creationParams: {
        'progressColor': {
          'r': progressColor.r,
          'g': progressColor.g,
          'b': progressColor.b,
          'a': progressColor.a
        },
        'trackColor': {
          'r': trackColor.r,
          'g': trackColor.g,
          'b': trackColor.b,
          'a': trackColor.a
        },
        'thickness': thickness,
        'value': value,
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  @override
  Widget buildDeterminateLinearProgressIndicator({
    required Color progressColor,
    required Color trackColor,
    required double thickness,
    required BorderRadius borderRadius,
    required double value,
  }) {
    return UiKitView(
      viewType:
          'native_progress_indicator/determinate_linear_progress_indicator',
      layoutDirection: TextDirection.ltr,
      creationParams: {
        'progressColor': {
          'r': progressColor.r,
          'g': progressColor.g,
          'b': progressColor.b,
          'a': progressColor.a
        },
        'trackColor': {
          'r': trackColor.r,
          'g': trackColor.g,
          'b': trackColor.b,
          'a': trackColor.a
        },
        'thickness': thickness,
        'value': value,
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  @override
  Widget buildIndeterminateCircularProgressIndicator({
    required Color progressColor,
    required Color trackColor,
    required double thickness,
    required double size,
  }) {
    return UiKitView(
      viewType:
          'native_progress_indicator/indeterminate_circular_progress_indicator',
      layoutDirection: TextDirection.ltr,
      creationParams: {
        'progressColor': {
          'r': progressColor.r,
          'g': progressColor.g,
          'b': progressColor.b,
          'a': progressColor.a
        },
        'trackColor': {
          'r': trackColor.r,
          'g': trackColor.g,
          'b': trackColor.b,
          'a': trackColor.a
        },
        'thickness': thickness
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  @override
  Widget buildIndeterminateLinearProgressIndicator(
      {required Color progressColor,
      required Color trackColor,
      required double thickness,
      required BorderRadius borderRadius}) {
    return UiKitView(
      viewType:
          'native_progress_indicator/indeterminate_linear_progress_indicator',
      layoutDirection: TextDirection.ltr,
      creationParams: {
        'progressColor': {
          'r': progressColor.r,
          'g': progressColor.g,
          'b': progressColor.b,
          'a': progressColor.a
        },
        'trackColor': {
          'r': trackColor.r,
          'g': trackColor.g,
          'b': trackColor.b,
          'a': trackColor.a
        },
        'thickness': thickness
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
