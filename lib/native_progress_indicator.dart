import 'package:flutter/material.dart';
import 'package:native_progress_indicator/native_progress_indicator_platform_interface.dart';

export 'native_progress_indicator_ios.dart';
export 'native_progress_indicator_android.dart';

class NativeCircularProgressIndicator extends StatefulWidget {
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
  State<NativeCircularProgressIndicator> createState() =>
      _NativeCircularProgressIndicatorState();
}

class _NativeCircularProgressIndicatorState
    extends State<NativeCircularProgressIndicator> {
  int? _viewId;

  @override
  Widget build(BuildContext context) {
    final value = widget.value;
    final color = widget.color ?? Theme.of(context).primaryColor;
    final trackColor = widget.backgroundColor ??
        ProgressIndicatorTheme.of(context).circularTrackColor ??
        (Colors.transparent);
    return _buildSemanticsWrapper(
      context: context,
      semanticsLabel: widget.semanticsLabel,
      semanticsValue: widget.semanticsValue,
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
                      strokeWidth: widget.strokeWidth,
                      size: constraints.maxWidth,
                      onPlatformViewCreated: (viewId) => _viewId = viewId)
              : NativeProgressIndicatorPlatform.instance
                  .buildDeterminateCircularProgressIndicator(
                  progressColor: color,
                  trackColor: trackColor,
                  strokeWidth: widget.strokeWidth,
                  value: value,
                  size: constraints.maxWidth,
                  onPlatformViewCreated: (viewId) => _viewId = viewId,
                ),
        ),
      ),
    );
  }
}

class NativeLinearProgressIndicator extends StatefulWidget {
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
  State<NativeLinearProgressIndicator> createState() =>
      _NativeLinearProgressIndicatorState();
}

class _NativeLinearProgressIndicatorState
    extends State<NativeLinearProgressIndicator> {
  int? _viewId;

  @override
  Widget build(BuildContext context) {
    final height = widget.minHeight ??
        Theme.of(context).progressIndicatorTheme.linearMinHeight ??
        4;
    final value = widget.value;
    final color = widget.color ?? Theme.of(context).primaryColor;
    final trackColor = widget.backgroundColor ??
        Theme.of(context).progressIndicatorTheme.linearTrackColor ??
        Theme.of(context).colorScheme.secondaryContainer;
    return _buildSemanticsWrapper(
      context: context,
      semanticsLabel: widget.semanticsLabel,
      semanticsValue: widget.semanticsValue,
      value: value,
      child: SizedBox(
        height: height,
        child: LayoutBuilder(
          builder: (context, constraints) => value == null
              ? NativeProgressIndicatorPlatform.instance
                  .buildIndeterminateLinearProgressIndicator(
                  progressColor: color,
                  trackColor: trackColor,
                  borderRadius:
                      widget.borderRadius?.resolve(TextDirection.ltr) ??
                          BorderRadius.zero,
                  height: height,
                  onPlatformViewCreated: (viewId) => _viewId = viewId,
                )
              : NativeProgressIndicatorPlatform.instance
                  .buildDeterminateLinearProgressIndicator(
                  progressColor: color,
                  trackColor: trackColor,
                  borderRadius:
                      widget.borderRadius?.resolve(TextDirection.ltr) ??
                          BorderRadius.zero,
                  height: height,
                  value: value,
                  onPlatformViewCreated: (viewId) => _viewId = viewId,
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
