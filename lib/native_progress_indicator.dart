import 'package:flutter/material.dart';
import 'package:native_progress_indicator/native_progress_indicator_platform_interface.dart';

export 'native_progress_indicator_ios.dart';

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
        ProgressIndicatorTheme.of(context).circularTrackColor ??
        (Colors.transparent);
    return _buildSemanticsWrapper(
      context: context,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      value: value,
      child: SizedBox(
        height: 36,
        width: 36,
        child: LayoutBuilder(
          builder: (context, constraints) => value == null
              ? NativeProgressIndicatorPlatform.instance
                  .buildIndeterminateCircularProgressIndicator(
                  progressColor: color,
                  trackColor: trackColor,
                  thickness: strokeWidth,
                  size: constraints.maxWidth,
                )
              : NativeProgressIndicatorPlatform.instance
                  .buildDeterminateCircularProgressIndicator(
                  progressColor: color,
                  trackColor: trackColor,
                  thickness: strokeWidth,
                  value: value,
                  size: constraints.maxWidth,
                ),
        ),
      ),
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
        Theme.of(context).colorScheme.secondaryContainer;
    return _buildSemanticsWrapper(
      context: context,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      value: value,
      child: SizedBox(
        height: height,
        child: LayoutBuilder(
          builder: (context, constraints) => value == null
              ? NativeProgressIndicatorPlatform.instance
                  .buildIndeterminateLinearProgressIndicator(
                  progressColor: color,
                  trackColor: trackColor,
                  borderRadius: borderRadius?.resolve(TextDirection.ltr) ??
                      BorderRadius.zero,
                  thickness: height,
                )
              : NativeProgressIndicatorPlatform.instance
                  .buildDeterminateLinearProgressIndicator(
                  progressColor: color,
                  trackColor: trackColor,
                  borderRadius: borderRadius?.resolve(TextDirection.ltr) ??
                      BorderRadius.zero,
                  thickness: height,
                  value: value,
                ),
        ),
      ),
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
