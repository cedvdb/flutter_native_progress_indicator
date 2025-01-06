import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

export 'src/native_progress_indicator_android.dart';
export 'src/native_progress_indicator_ios.dart';
export 'src/native_progress_indicator_web.dart';

extension _ColorMapExtension on Color {
  Map<String, double> toMap() {
    return {'a': a, 'r': r, 'g': g, 'b': b};
  }

  static Color fromMap(Map<String, double> map) {
    return Color.from(
        alpha: map['a'] as double,
        red: map['r'] as double,
        green: map['g'] as double,
        blue: map['b'] as double);
  }
}

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

  Map<String, Object?> toMap() {
    return {
      'progressColor': progressColor.toMap(),
      'trackColor': trackColor.toMap(),
      'strokeWidth': strokeWidth,
      'value': value,
      'size': size,
    };
  }

  factory CircularProgressIndicatorParams.fromMap(Map<String, dynamic> map) {
    return CircularProgressIndicatorParams(
      value: map['value'] as double?,
      progressColor: _ColorMapExtension.fromMap(
          (map['progressColor'] as Map).cast<String, double>()),
      trackColor: _ColorMapExtension.fromMap(
          (map['trackColor'] as Map).cast<String, double>()),
      strokeWidth: (map['strokeWidth'] as num).toDouble(),
      size: (map['size'] as num).toDouble(),
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

  Map<String, Object?> toMap() {
    return {
      'progressColor': progressColor.toMap(),
      'trackColor': trackColor.toMap(),
      'height': height,
      'value': value,
      'borderRadius': {
        'topLeft': borderRadius.topLeft.x,
        'topRight': borderRadius.topRight.x,
        'bottomLeft': borderRadius.bottomLeft.x,
        'bottomRight': borderRadius.bottomRight.x,
      },
    };
  }

  factory LinearProgressIndicatorParams.fromMap(Map<String, dynamic> map) {
    return LinearProgressIndicatorParams(
      value: map['value'] as double?,
      progressColor: _ColorMapExtension.fromMap(
          (map['progressColor'] as Map).cast<String, double>()),
      trackColor: _ColorMapExtension.fromMap(
          (map['trackColor'] as Map).cast<String, double>()),
      height: (map['height'] as num).toDouble(),
      borderRadius: BorderRadius.only(
        topLeft:
            Radius.circular((map['borderRadius']['topLeft'] as num).toDouble()),
        topRight: Radius.circular(
            (map['borderRadius']['topRight'] as num).toDouble()),
        bottomLeft: Radius.circular(
            (map['borderRadius']['bottomLeft'] as num).toDouble()),
        bottomRight: Radius.circular(
            (map['borderRadius']['bottomRight'] as num).toDouble()),
      ),
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
