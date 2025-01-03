import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:native_progress_indicator/native_progress_indicator_platform_interface.dart';

extension _MapExtension on Color {
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
  final _channel = MethodChannel(
    'native_progress_indicator',
  );

  static void registerWith() {
    NativeProgressIndicatorPlatform.instance = NativeProgressIndicatorAndroid();
  }

  @override
  Widget buildCircularProgressIndicator({
    required CircularProgressIndicatorParams params,
    required Function(int viewId) onPlatformViewCreated,
  }) {
    return AndroidView(
      viewType: 'native_progress_indicator/circular',
      creationParams: {
        'progressColor': params.progressColor.toMap(),
        'trackColor': params.trackColor.toMap(),
        'strokeWidth': params.strokeWidth,
        'value': params.value,
        'size': params.size,
      },
      creationParamsCodec: const StandardMessageCodec(),
      onPlatformViewCreated: (int viewId) {
        onPlatformViewCreated(viewId);
      },
    );
  }

  @override
  Widget buildLinearProgressIndicator({
    required LinearProgressIndicatorParams params,
    required Function(int viewId) onPlatformViewCreated,
  }) {
    return AndroidView(
      viewType: 'native_progress_indicator/linear',
      creationParams: {
        'progressColor': params.progressColor.toMap(),
        'trackColor': params.trackColor.toMap(),
        'height': params.height,
        'value': params.value,
      },
      creationParamsCodec: const StandardMessageCodec(),
      onPlatformViewCreated: (int viewId) {
        onPlatformViewCreated(viewId);
      },
    );
  }

  @override
  void updateCircularIndicator({
    required CircularProgressIndicatorParams params,
    required int viewId,
  }) {
    _channel.invokeMethod('updateCircularIndicator', {
      'viewId': viewId,
      'params': {
        'progressColor': params.progressColor.toMap(),
        'trackColor': params.trackColor.toMap(),
        'strokeWidth': params.strokeWidth,
        'value': params.value,
        'size': params.size,
      }
    });
  }

  @override
  void updateLinearIndicator({
    required LinearProgressIndicatorParams params,
    required int viewId,
  }) {
    _channel.invokeMethod('updateLinearIndicator', {
      'viewId': viewId,
      'params': {
        'progressColor': params.progressColor.toMap(),
        'trackColor': params.trackColor.toMap(),
        'height': params.height,
        'value': params.value,
      }
    });
  }
}
