import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:native_progress_indicator/native_progress_indicator_platform_interface.dart';

class NativeProgressIndicatorIos implements NativeProgressIndicatorPlatform {
  static void registerWith() {
    NativeProgressIndicatorPlatform.instance = NativeProgressIndicatorIos();
  }

  void _initChannel(int viewId) {
    // Initialize a channel scoped to this view instance
    final viewChannel = MethodChannel(
      'native_progress_indicator/view_$viewId',
    );

    // Handle incoming messages if necessary
    viewChannel.setMethodCallHandler((call) async {
      // Handle method calls from the native side if needed
    });
  }

  @override
  Widget buildDeterminateCircularProgressIndicator({
    required Color progressColor,
    required Color trackColor,
    required double strokeWidth,
    required double value,
    required double size,
    required Function(int viewId) onPlatformViewCreated,
  }) {
    return UiKitView(
      viewType:
          'native_progress_indicator/determinate_circular_progress_indicator',
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
        'strokeWidth': strokeWidth,
        'value': value,
      },
      creationParamsCodec: const StandardMessageCodec(),
      onPlatformViewCreated: (int viewId) {
        _initChannel(viewId);
        onPlatformViewCreated(viewId);
      },
    );
  }

  @override
  Widget buildDeterminateLinearProgressIndicator({
    required Color progressColor,
    required Color trackColor,
    required double height,
    required BorderRadius borderRadius,
    required double value,
    required Function(int viewId) onPlatformViewCreated,
  }) {
    return UiKitView(
      viewType:
          'native_progress_indicator/determinate_linear_progress_indicator',
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
        'height': height,
        'value': value,
      },
      creationParamsCodec: const StandardMessageCodec(),
      onPlatformViewCreated: (int viewId) {
        _initChannel(viewId);
        onPlatformViewCreated(viewId);
      },
    );
  }

  @override
  Widget buildIndeterminateCircularProgressIndicator({
    required Color progressColor,
    required Color trackColor,
    required double strokeWidth,
    required double size,
    required Function(int viewId) onPlatformViewCreated,
  }) {
    return UiKitView(
      viewType:
          'native_progress_indicator/indeterminate_circular_progress_indicator',
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
        'strokeWidth': strokeWidth
      },
      creationParamsCodec: const StandardMessageCodec(),
      onPlatformViewCreated: (int viewId) {
        _initChannel(viewId);
        onPlatformViewCreated(viewId);
      },
    );
  }

  @override
  Widget buildIndeterminateLinearProgressIndicator({
    required Color progressColor,
    required Color trackColor,
    required double height,
    required BorderRadius borderRadius,
    required Function(int viewId) onPlatformViewCreated,
  }) {
    return UiKitView(
      viewType:
          'native_progress_indicator/indeterminate_linear_progress_indicator',
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
        'height': height
      },
      creationParamsCodec: const StandardMessageCodec(),
      onPlatformViewCreated: (int viewId) {
        _initChannel(viewId);
        onPlatformViewCreated(viewId);
      },
    );
  }
}
