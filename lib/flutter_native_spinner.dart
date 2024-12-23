import 'dart:math';

import 'package:flutter/material.dart';

import 'flutter_native_spinner_platform_interface.dart';

class NativeCircularProgressIndicator extends StatelessWidget {
  final double? value;
  final Color? color;
  final Color? backgroundColor;
  final double strokeWidth;
  final String? semanticsLabel;
  final String? semanticsValue;

  const NativeCircularProgressIndicator({
    super.key,
    this.value,
    this.color,
    this.backgroundColor,
    this.strokeWidth = 4.0,
    this.semanticsLabel,
    this.semanticsValue,
  });

  @override
  Widget build(BuildContext context) {
    final value = this.value;
    final color = this.color ?? Theme.of(context).primaryColor;
    final trackColor = backgroundColor ??
        Theme.of(context).progressIndicatorTheme.circularTrackColor ??
        Colors.transparent;
    final spinner = LayoutBuilder(
      builder: (context, constraints) {
        final size = min(constraints.maxHeight, constraints.maxWidth);
        return SizedBox(
          height: size,
          width: size,
          child: value == null
              ? FlutterNativeSpinnerPlatform.instance
                  .buildIndeterminateCircularProgressIndicator(
                  color: color,
                  trackColor: trackColor,
                  strokeWidth: strokeWidth,
                )
              : FlutterNativeSpinnerPlatform.instance
                  .buildDeterminateCircularProgressIndicator(
                  color: color,
                  trackColor: trackColor,
                  strokeWidth: strokeWidth,
                  value: value,
                ),
        );
      },
    );
    return _buildSemanticsWrapper(
      context: context,
      child: spinner,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      value: value,
    );
  }
}

class NativeLinearProgressIndicator extends StatelessWidget {
  final double? value;
  final Color? color;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final String? semanticsLabel;
  final String? semanticsValue;
  final double? minHeight;

  const NativeLinearProgressIndicator({
    super.key,
    this.value,
    this.color,
    this.backgroundColor,
    this.semanticsLabel,
    this.semanticsValue,
    this.minHeight,
    this.borderRadius,
  }) : assert(minHeight == null || minHeight > 0);

  @override
  Widget build(BuildContext context) {
    final height = minHeight ??
        Theme.of(context).progressIndicatorTheme.linearMinHeight ??
        4;
    final value = this.value;
    final color = this.color ?? Theme.of(context).primaryColor;
    final trackColor = backgroundColor ??
        Theme.of(context).progressIndicatorTheme.linearTrackColor ??
        Colors.transparent;
    final spinner = LayoutBuilder(
      builder: (context, constraints) {
        final size = min(constraints.maxHeight, constraints.maxWidth);
        return SizedBox(
          height: size,
          width: size,
          child: value == null
              ? FlutterNativeSpinnerPlatform.instance
                  .buildIndeterminateLinearProgressIndicator(
                  color: color,
                  trackColor: trackColor,
                  borderRadius: borderRadius?.resolve(TextDirection.ltr) ??
                      BorderRadius.zero,
                  height: height,
                )
              : FlutterNativeSpinnerPlatform.instance
                  .buildIndeterminateLinearProgressIndicator(
                  color: color,
                  trackColor: trackColor,
                  borderRadius: borderRadius?.resolve(TextDirection.ltr) ??
                      BorderRadius.zero,
                  height: height,
                ),
        );
      },
    );
    return _buildSemanticsWrapper(
      context: context,
      child: spinner,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      value: value,
    );
  }
}

Widget _buildSemanticsWrapper({
  required BuildContext context,
  required Widget child,
  required String? semanticsValue,
  required String? semanticsLabel,
  required double? value,
}) {
  String? expandedSemanticsValue = semanticsValue;
  if (value != null) {
    expandedSemanticsValue ??= '${(value * 100).round()}%';
  }
  return Semantics(
    label: semanticsLabel,
    value: expandedSemanticsValue,
    child: child,
  );
}
