import 'package:flutter/material.dart';
import 'package:native_progress_indicator/native_progress_indicator_platform_interface.dart';

export 'src/native_progress_indicator_ios.dart';
export 'src/native_progress_indicator_android.dart';

export '';

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
  late CircularProgressIndicatorParams params;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final value = widget.value;
    final progressColor = widget.color ?? Theme.of(context).primaryColor;
    final trackColor = widget.backgroundColor ??
        ProgressIndicatorTheme.of(context).circularTrackColor ??
        (Colors.transparent);
    params = CircularProgressIndicatorParams(
      value: value,
      progressColor: progressColor,
      trackColor: trackColor,
      strokeWidth: widget.strokeWidth,
      size: 36,
    );
  }

  @override
  void didUpdateWidget(covariant NativeCircularProgressIndicator oldWidget) {
    final viewId = _viewId;
    final hasChanged = widget.value != oldWidget.value ||
        widget.backgroundColor != oldWidget.backgroundColor ||
        widget.color != oldWidget.color ||
        widget.semanticsLabel != oldWidget.semanticsLabel ||
        widget.semanticsValue != oldWidget.semanticsValue ||
        widget.strokeWidth != oldWidget.strokeWidth;

    if (hasChanged && viewId != null) {
      final value = widget.value;
      final progressColor = widget.color ?? Theme.of(context).primaryColor;
      final trackColor = widget.backgroundColor ??
          ProgressIndicatorTheme.of(context).circularTrackColor ??
          (Colors.transparent);
      params = params.copyWith(
        value: value,
        progressColor: progressColor,
        trackColor: trackColor,
        strokeWidth: widget.strokeWidth,
      );
      NativeProgressIndicatorPlatform.instance
          .updateCircularIndicator(params: params, viewId: viewId);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return _buildSemanticsWrapper(
      context: context,
      semanticsLabel: widget.semanticsLabel,
      semanticsValue: widget.semanticsValue,
      value: params.value,
      child: SizedBox(
        height: 36,
        width: 36,
        child: LayoutBuilder(
          builder: (context, constraints) {
            params = params.copyWith(size: constraints.maxWidth);
            return NativeProgressIndicatorPlatform.instance
                .buildCircularProgressIndicator(
                    params: params,
                    onPlatformViewCreated: (viewId) => _viewId = viewId);
          },
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
  late LinearProgressIndicatorParams params;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final value = widget.value;
    final progressColor = widget.color ?? Theme.of(context).primaryColor;
    final trackColor = widget.backgroundColor ??
        ProgressIndicatorTheme.of(context).circularTrackColor ??
        (Colors.transparent);
    final height = widget.minHeight ??
        Theme.of(context).progressIndicatorTheme.linearMinHeight ??
        4;
    params = LinearProgressIndicatorParams(
      value: value,
      progressColor: progressColor,
      trackColor: trackColor,
      borderRadius:
          widget.borderRadius?.resolve(TextDirection.ltr) ?? BorderRadius.zero,
      height: height,
    );
  }

  @override
  void didUpdateWidget(covariant NativeLinearProgressIndicator oldWidget) {
    final viewId = _viewId;
    final hasChanged = widget.value != oldWidget.value ||
        widget.backgroundColor != oldWidget.backgroundColor ||
        widget.color != oldWidget.color ||
        widget.semanticsLabel != oldWidget.semanticsLabel ||
        widget.semanticsValue != oldWidget.semanticsValue ||
        widget.minHeight != oldWidget.minHeight ||
        widget.borderRadius != oldWidget.borderRadius;
    if (hasChanged && viewId != null) {
      final value = widget.value;
      final progressColor = widget.color ?? Theme.of(context).primaryColor;
      final trackColor = widget.backgroundColor ??
          ProgressIndicatorTheme.of(context).circularTrackColor ??
          (Colors.transparent);
      final height = widget.minHeight ??
          Theme.of(context).progressIndicatorTheme.linearMinHeight ??
          4;
      params = params.copyWith(
        value: value,
        progressColor: progressColor,
        trackColor: trackColor,
        borderRadius: widget.borderRadius?.resolve(TextDirection.ltr) ??
            BorderRadius.zero,
        height: height,
      );
      NativeProgressIndicatorPlatform.instance
          .updateLinearIndicator(params: params, viewId: viewId);
    }
    super.didUpdateWidget(oldWidget);
  }

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
          builder: (context, constraints) => NativeProgressIndicatorPlatform
              .instance
              .buildLinearProgressIndicator(
            params: LinearProgressIndicatorParams(
              value: value,
              progressColor: color,
              trackColor: trackColor,
              borderRadius: widget.borderRadius?.resolve(TextDirection.ltr) ??
                  BorderRadius.zero,
              height: height,
            ),
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
