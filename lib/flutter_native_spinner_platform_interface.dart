import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_native_spinner_method_channel.dart';

abstract class FlutterNativeSpinnerPlatform extends PlatformInterface {
  /// Constructs a FlutterNativeSpinnerPlatform.
  FlutterNativeSpinnerPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterNativeSpinnerPlatform _instance =
      MethodChannelFlutterNativeSpinner();

  /// The default instance of [FlutterNativeSpinnerPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterNativeSpinner].
  static FlutterNativeSpinnerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterNativeSpinnerPlatform] when
  /// they register themselves.
  static set instance(FlutterNativeSpinnerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Widget buildIndeterminateCircularProgressIndicator({
    required Color color,
    required Color trackColor,
    required double strokeWidth,
  }) {
    throw UnimplementedError(
        'buildIndeterminateCircularProgressIndicator() has not been implemented.');
  }

  Widget buildDeterminateCircularProgressIndicator({
    required Color color,
    required Color trackColor,
    required double strokeWidth,
    required double value,
  }) {
    throw UnimplementedError(
        'buildDeterminateCircularProgressIndicator() has not been implemented.');
  }

  Widget buildIndeterminateLinearProgressIndicator({
    required Color color,
    required Color trackColor,
    required double height,
    required BorderRadius borderRadius,
  }) {
    throw UnimplementedError(
        'buildIndeterminateCircularProgressIndicator() has not been implemented.');
  }

  Widget buildDeterminateLinearProgressIndicator({
    required Color color,
    required double strokeWidth,
    required double value,
  }) {
    throw UnimplementedError(
        'buildIndeterminateCircularProgressIndicator() has not been implemented.');
  }
}
