import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class NativeProgressIndicatorPlatform extends PlatformInterface {
  /// Constructs a NativeProgressIndicatorPlatform.
  NativeProgressIndicatorPlatform() : super(token: _token);

  static final Object _token = Object();

  static late NativeProgressIndicatorPlatform instance;

  Widget buildIndeterminateCircularProgressIndicator({
    required Color progressColor,
    required Color trackColor,
    required double strokeWidth,
    required double size,
    required Function(int viewId) onPlatformViewCreated,
  }) {
    throw UnimplementedError(
        'buildIndeterminateCircularProgressIndicator() has not been implemented.');
  }

  Widget buildDeterminateCircularProgressIndicator({
    required Color progressColor,
    required Color trackColor,
    required double strokeWidth,
    required double value,
    required double size,
    required Function(int viewId) onPlatformViewCreated,
  }) {
    throw UnimplementedError(
        'buildDeterminateCircularProgressIndicator() has not been implemented.');
  }

  Widget buildIndeterminateLinearProgressIndicator({
    required Color progressColor,
    required Color trackColor,
    required double height,
    required BorderRadius borderRadius,
    required Function(int viewId) onPlatformViewCreated,
  }) {
    throw UnimplementedError(
        'buildIndeterminateCircularProgressIndicator() has not been implemented.');
  }

  Widget buildDeterminateLinearProgressIndicator({
    required Color progressColor,
    required Color trackColor,
    required double height,
    required BorderRadius borderRadius,
    required double value,
    required Function(int viewId) onPlatformViewCreated,
  }) {
    throw UnimplementedError(
        'buildIndeterminateCircularProgressIndicator() has not been implemented.');
  }
}
