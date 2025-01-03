import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class CircularProgressIndicatorParams {
  final double? value;
  final Color progressColor;
  final Color trackColor;
  final double strokeWidth;
  final double size;

  CircularProgressIndicatorParams({
    required this.value,
    required this.progressColor,
    required this.trackColor,
    required this.strokeWidth,
    required this.size,
  });

  CircularProgressIndicatorParams copyWith({
    double? value,
    Color? progressColor,
    Color? trackColor,
    double? strokeWidth,
    double? size,
  }) {
    return CircularProgressIndicatorParams(
      value: value ?? this.value,
      progressColor: progressColor ?? this.progressColor,
      trackColor: trackColor ?? this.trackColor,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      size: size ?? this.size,
    );
  }
}

class LinearProgressIndicatorParams {
  final double? value;
  final Color progressColor;
  final Color trackColor;
  final double height;
  final BorderRadius borderRadius;

  LinearProgressIndicatorParams({
    required this.value,
    required this.progressColor,
    required this.trackColor,
    required this.height,
    required this.borderRadius,
  });

  LinearProgressIndicatorParams copyWith({
    double? value,
    Color? progressColor,
    Color? trackColor,
    double? height,
    BorderRadius? borderRadius,
  }) {
    return LinearProgressIndicatorParams(
      value: value ?? this.value,
      progressColor: progressColor ?? this.progressColor,
      trackColor: trackColor ?? this.trackColor,
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}

abstract class NativeProgressIndicatorPlatform extends PlatformInterface {
  /// Constructs a NativeProgressIndicatorPlatform.
  NativeProgressIndicatorPlatform() : super(token: _token);

  static final Object _token = Object();

  static late NativeProgressIndicatorPlatform instance;

  Widget buildCircularProgressIndicator({
    required CircularProgressIndicatorParams params,
    required Function(int viewId) onPlatformViewCreated,
  }) {
    throw UnimplementedError();
  }

  void updateCircularIndicator({
    required CircularProgressIndicatorParams params,
    required int viewId,
  }) {
    throw UnimplementedError();
  }

  Widget buildLinearProgressIndicator({
    required LinearProgressIndicatorParams params,
    required Function(int viewId) onPlatformViewCreated,
  }) {
    throw UnimplementedError();
  }

  void updateLinearIndicator({
    required LinearProgressIndicatorParams params,
    required int viewId,
  }) {
    throw UnimplementedError();
  }
}
