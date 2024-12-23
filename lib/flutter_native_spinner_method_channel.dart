import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_native_spinner_platform_interface.dart';

/// An implementation of [FlutterNativeSpinnerPlatform] that uses method channels.
class MethodChannelFlutterNativeSpinner extends FlutterNativeSpinnerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_native_spinner');
}
