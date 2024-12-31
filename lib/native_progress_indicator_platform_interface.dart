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
    required double thickness,
    required double size,
  }) {
    throw UnimplementedError(
        'buildIndeterminateCircularProgressIndicator() has not been implemented.');
  }

  Widget buildDeterminateCircularProgressIndicator({
    required Color progressColor,
    required Color trackColor,
    required double thickness,
    required double value,
    required double size,
  }) {
    throw UnimplementedError(
        'buildDeterminateCircularProgressIndicator() has not been implemented.');
  }

  Widget buildIndeterminateLinearProgressIndicator({
    required Color progressColor,
    required Color trackColor,
    required double thickness,
    required BorderRadius borderRadius,
  }) {
    throw UnimplementedError(
        'buildIndeterminateCircularProgressIndicator() has not been implemented.');
  }

  Widget buildDeterminateLinearProgressIndicator({
    required Color progressColor,
    required Color trackColor,
    required double thickness,
    required BorderRadius borderRadius,
    required double value,
  }) {
    throw UnimplementedError(
        'buildIndeterminateCircularProgressIndicator() has not been implemented.');
  }
}
