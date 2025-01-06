import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:native_progress_indicator/native_progress_indicator_platform_interface.dart';

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
      creationParams: params.toMap(),
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
      creationParams: params.toMap(),
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
    _channel.invokeMethod('updateCircularIndicator',
        {'viewId': viewId, 'params': params.toMap()});
  }

  @override
  void updateLinearIndicator({
    required LinearProgressIndicatorParams params,
    required int viewId,
  }) {
    _channel.invokeMethod(
        'updateLinearIndicator', {'viewId': viewId, 'params': params.toMap()});
  }
}
