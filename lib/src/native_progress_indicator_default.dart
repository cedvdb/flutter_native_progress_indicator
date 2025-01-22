import 'package:flutter/material.dart';
import 'package:native_progress_indicator/native_progress_indicator_platform_interface.dart';

class NativeProgressIndicatorDefault
    implements NativeProgressIndicatorPlatform {
  @override
  Widget buildCircularProgressIndicator({
    required CircularProgressIndicatorParams params,
    required Function(int viewId) onPlatformViewCreated,
  }) {
    return CircularProgressIndicator(
      value: params.value,
      backgroundColor: params.trackColor,
      color: params.progressColor,
      strokeWidth: params.strokeWidth,
    );
  }

  @override
  Widget buildLinearProgressIndicator({
    required LinearProgressIndicatorParams params,
    required Function(int viewId) onPlatformViewCreated,
  }) {
    return LinearProgressIndicator(
      value: params.value,
      backgroundColor: params.trackColor,
      color: params.progressColor,
      minHeight: params.height,
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
  }) {}
}
