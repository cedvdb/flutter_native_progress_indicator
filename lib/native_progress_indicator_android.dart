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

  Future<void> updateProgressIndicator(
    int viewId,
    Map<String, Object?> params,
  ) async {
    final viewChannel = MethodChannel(
      'native_progress_indicator/view_$viewId',
    );
    await viewChannel.invokeMethod('updateParams', params);
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
    return AndroidView(
      viewType:
          'native_progress_indicator/determinate_circular_progress_indicator',
      creationParams: {
        'progressColor': progressColor.toMap(),
        'trackColor': trackColor.toMap(),
        'strokeWidth': strokeWidth,
        'value': value,
        'size': size,
        'type': 'circular'
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
    return AndroidView(
      viewType:
          'native_progress_indicator/determinate_linear_progress_indicator',
      creationParams: {
        'progressColor': progressColor.toMap(),
        'trackColor': trackColor.toMap(),
        'height': height,
        'value': value,
        'type': 'linear'
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
    return AndroidView(
      viewType:
          'native_progress_indicator/indeterminate_circular_progress_indicator',
      creationParams: {
        'progressColor': progressColor.toMap(),
        'trackColor': trackColor.toMap(),
        'strokeWidth': strokeWidth,
        'size': size,
        'type': 'circular'
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
    return AndroidView(
      viewType:
          'native_progress_indicator/indeterminate_linear_progress_indicator',
      creationParams: {
        'progressColor': progressColor.toMap(),
        'trackColor': trackColor.toMap(),
        'height': height,
        'type': 'linear'
      },
      creationParamsCodec: const StandardMessageCodec(),
      onPlatformViewCreated: (int viewId) {
        _initChannel(viewId);
        onPlatformViewCreated(viewId);
      },
    );
  }
}
