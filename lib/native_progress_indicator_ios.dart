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
  Widget buildCircularProgressIndicator({
    required CircularProgressIndicatorParams params,
    required Function(int viewId) onPlatformViewCreated,
  }) {
    return UiKitView(
      viewType: 'native_progress_indicator/circular',
      creationParams: {
        'progressColor': {
          'r': params.progressColor.r * 255,
          'g': params.progressColor.g * 255,
          'b': params.progressColor.b * 255,
          'a': params.progressColor.a * 255
        },
        'trackColor': {
          'r': params.trackColor.r * 255,
          'g': params.trackColor.g * 255,
          'b': params.trackColor.b * 255,
          'a': params.trackColor.a * 255
        },
        'strokeWidth': params.strokeWidth,
        'value': params.value,
      },
      creationParamsCodec: const StandardMessageCodec(),
      onPlatformViewCreated: (int viewId) {
        _initChannel(viewId);
        onPlatformViewCreated(viewId);
      },
    );
  }

  @override
  Widget buildLinearProgressIndicator({
    required LinearProgressIndicatorParams params,
    required Function(int viewId) onPlatformViewCreated,
  }) {
    return UiKitView(
      viewType: 'native_progress_indicator/linear',
      creationParams: {
        'progressColor': {
          'r': params.progressColor.r * 255,
          'g': params.progressColor.g * 255,
          'b': params.progressColor.b * 255,
          'a': params.progressColor.a * 255
        },
        'trackColor': {
          'r': params.trackColor.r * 255,
          'g': params.trackColor.g * 255,
          'b': params.trackColor.b * 255,
          'a': params.trackColor.a * 255
        },
        'height': params.height,
        'value': params.value,
      },
      creationParamsCodec: const StandardMessageCodec(),
      onPlatformViewCreated: (int viewId) {
        _initChannel(viewId);
        onPlatformViewCreated(viewId);
      },
    );
  }

  @override
  void updateCircularIndicator({
    required CircularProgressIndicatorParams params,
    required int viewId,
  }) {}

  @override
  void updateLinearIndicator({
    required LinearProgressIndicatorParams params,
    required int viewId,
  }) {
    // TODO: implement updateLinearIndicator
  }
}
