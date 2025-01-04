// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'dart:ui_web' as ui_web;

import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:native_progress_indicator/native_progress_indicator_platform_interface.dart';
import 'package:web/web.dart' as web;

/// A web implementation of the FlutterNativeSpinnerPlatform of the FlutterNativeSpinner plugin.
class NativeProgressIndicatorWeb implements NativeProgressIndicatorPlatform {
  /// Constructs a FlutterNativeSpinnerWeb
  NativeProgressIndicatorWeb();

  static final Map<int, _CircularProgressIndicatorFactory> _circularIndicators =
      {};
  static final Map<int, _LinearProgressIndicatorFactory> _linearIndicators = {};

  static void registerWith(Registrar registrar) {
    NativeProgressIndicatorPlatform.instance = NativeProgressIndicatorWeb();
  }

  @override
  Widget buildCircularProgressIndicator({
    required CircularProgressIndicatorParams params,
    required Function(int viewId) onPlatformViewCreated,
  }) {
    final builder = _CircularProgressIndicatorFactory();
    final view = builder.build(
      params: params,
      onCreated: (viewId) {
        _circularIndicators[viewId] = builder;
        onPlatformViewCreated(viewId);
      },
    );
    return view;
  }

  @override
  Widget buildLinearProgressIndicator({
    required LinearProgressIndicatorParams params,
    required Function(int viewId) onPlatformViewCreated,
  }) {
    final builder = _LinearProgressIndicatorFactory();
    final view = builder.build(
      params: params,
      onCreated: (viewId) {
        _linearIndicators[viewId] = builder;
        onPlatformViewCreated(viewId);
      },
    );

    return view;
  }

  @override
  void updateCircularIndicator({
    required CircularProgressIndicatorParams params,
    required int viewId,
  }) {
    print('updating $viewId');
    // _circularIndicators[viewId]?.setContent(
    //   params: params,
    //   viewId: viewId,
    // );
  }

  @override
  void updateLinearIndicator({
    required LinearProgressIndicatorParams params,
    required int viewId,
  }) {
    print('updating $viewId');

    _linearIndicators[viewId]?.setContent(
      params: params,
      viewId: viewId,
    );
  }
}

class _CircularProgressIndicatorFactory {
  static const String _id = 'circular-progress-indicator';
  web.HTMLDivElement? _div;

  _CircularProgressIndicatorFactory() {
    ui_web.platformViewRegistry.registerViewFactory(_id, (int viewId,
        {Object? params}) {
      final paramsParsed = CircularProgressIndicatorParams.fromMap(
          (params as Map).cast<String, dynamic>());
      final div = web.HTMLDivElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..className = 'circular-progress-indicator-$viewId';
      _div = div;
      setContent(
        params: paramsParsed,
        viewId: viewId,
      );
      return div;
    });
  }

  HtmlElementView build({
    required CircularProgressIndicatorParams params,
    required Function(int viewId) onCreated,
  }) {
    return HtmlElementView(
      viewType: _id,
      creationParams: params.toMap(),
      onPlatformViewCreated: onCreated,
    );
  }

  void setContent({
    required CircularProgressIndicatorParams params,
    required int viewId,
  }) {
    print('setting content circular view id: $viewId ');
    final value = params.value;
    final color = params.progressColor;
    final trackColor = params.trackColor;
    final size = params.size;
    final strokeWidth = params.strokeWidth;

    if (value != null) {
      _setContentDeterminate(
          value: value,
          color: color,
          trackColor: trackColor,
          strokeWidth: strokeWidth,
          size: size,
          viewId: viewId);
    } else {
      _setContentIndeterminate(
          color: color,
          trackColor: trackColor,
          strokeWidth: strokeWidth,
          size: size,
          viewId: viewId);
    }
  }

  void _setContentIndeterminate({
    required Color color,
    required Color trackColor,
    required double strokeWidth,
    required double size,
    required int viewId,
  }) {
    print('setting content indeterminate $viewId');

    _div?.innerHTML = '''
        ${_generateCss(strokeWidth: strokeWidth, color: color, trackColor: trackColor, size: size, viewId: viewId)}
        <div class="progress indeterminate">
          <div class="spinner">
            <div class="left">
              <div class="circle"></div>
            </div>
            <div class="right">
              <div class="circle"></div>
            </div>
          </div>
        </div>
        ''';
  }

  void _setContentDeterminate({
    required double value,
    required Color color,
    required Color trackColor,
    required double strokeWidth,
    required double size,
    required int viewId,
  }) {
    print('setting content determinate $viewId');
    final dashOffset = (1 - value) * 100;
    _div?.innerHTML = '''
      ${_generateCss(strokeWidth: strokeWidth, color: color, trackColor: trackColor, size: size, viewId: viewId)}
      <div class="progress">
        <svg viewBox="0 0 4800 4800">
          <circle class="track" pathLength="100"></circle>
          <circle
            class="active-track"
            pathLength="100"
            stroke-dashoffset="$dashOffset"></circle>
        </svg>
      </div>
      ''';
  }

// styles from https://github.com/material-components/material-web/blob/main/progress/internal/_circular-progress.scss
  String _generateCss({
    required double strokeWidth,
    required Color color,
    required Color trackColor,
    required double size,
    required int viewId,
  }) {
    print('generating css for $viewId');
    final arcDuration = Duration(milliseconds: 1333);
    final linearRotateDuration =
        Duration(milliseconds: (1333 * 360 / 306).toInt());
    final cycleDuration = Duration(milliseconds: 1333 * 4);
    final indeterminateEasing = 'cubic-bezier(0.4, 0, 0.2, 1)';
    final rgbColor =
        'rgb(${color.r * 255}, ${color.g * 255}, ${color.b * 255}, ${color.a})';
    final rgbTrackColor =
        'rgb(${trackColor.r * 255}, ${trackColor.g * 255}, ${trackColor.b * 255}, ${trackColor.a})';

    return '''
<style>

.circular-progress-indicator-$viewId {
  display: inline-flex;
  vertical-align: middle;
  width: 100%;
  height: 100%;
  position: relative;
  align-items: center;
  justify-content: center;
  contain: strict;
  content-visibility: auto;
}


.circular-progress-indicator-$viewId .progress {
  flex: 1;
  align-self: stretch;
}

.circular-progress-indicator-$viewId .progress,
.circular-progress-indicator-$viewId .spinner,
.circular-progress-indicator-$viewId .left,
.circular-progress-indicator-$viewId .right,
.circular-progress-indicator-$viewId .circle,
.circular-progress-indicator-$viewId svg,
.circular-progress-indicator-$viewId .track,
.circular-progress-indicator-$viewId .active-track{
  position: absolute;
  inset: 0;
}

.circular-progress-indicator-$viewId svg {
  transform: rotate(-90deg);
}

.circular-progress-indicator-$viewId circle {
  cx: 50%;
  cy: 50%;
  r: calc(50% * (1 - $strokeWidth / $size));
  stroke-width: calc($strokeWidth / $size * 4800);
  stroke-dasharray: 100;
  fill: transparent;
}

.circular-progress-indicator-$viewId .active-track {
  transition: stroke-dashoffset 500ms cubic-bezier(0, 0, 0.2, 1);
  stroke: $rgbColor;
}

.circular-progress-indicator-$viewId .track {
  stroke: $rgbTrackColor;
}

.circular-progress-indicator-$viewId .progress.indeterminate {
  animation: linear infinite linear-rotate;
  animation-duration: ${linearRotateDuration.inMilliseconds}ms;
}

.circular-progress-indicator-$viewId .spinner {
  animation: infinite both rotate-arc;
  animation-duration: ${cycleDuration.inMilliseconds}ms;
  animation-timing-function: $indeterminateEasing;
}

.circular-progress-indicator-$viewId .left {
  overflow: hidden;
  inset: 0 50% 0 0;
}

.circular-progress-indicator-$viewId .right {
  overflow: hidden;
  inset: 0 0 0 50%;
}

.circular-progress-indicator-$viewId .circle {
  box-sizing: border-box;
  border-radius: 50%;
  border: solid ${strokeWidth}px;
  border-color: $rgbColor $rgbColor transparent transparent;
  animation: expand-arc;
  animation-iteration-count: infinite;
  animation-fill-mode: both;
  animation-duration: ${arcDuration.inMilliseconds}ms, ${cycleDuration.inMilliseconds}ms;
  animation-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
}

.circular-progress-indicator-$viewId .left .circle {
  rotate: 135deg;
  inset: 0 -100% 0 0;
}
.circular-progress-indicator-$viewId .right .circle {
  rotate: 100deg;
  inset: 0 0 0 -100%;
  animation-delay: calc(-0.5 * ${arcDuration.inMilliseconds}ms), 0ms;
}

@media (forced-colors: active) {
  .circular-progress-indicator-$viewId .active-track {
    stroke: CanvasText;
  }

  .circular-progress-indicator-$viewId .circle {
    border-color: CanvasText CanvasText Canvas Canvas;
  }
}


@keyframes expand-arc {
  0% {
    transform: rotate(265deg);
  }
  50% {
    transform: rotate(130deg);
  }
  100% {
    transform: rotate(265deg);
  }
}

@keyframes rotate-arc {
  12.5% {
    transform: rotate(135deg);
  }
  25% {
    transform: rotate(270deg);
  }
  37.5% {
    transform: rotate(405deg);
  }
  50% {
    transform: rotate(540deg);
  }
  62.5% {
    transform: rotate(675deg);
  }
  75% {
    transform: rotate(810deg);
  }
  87.5% {
    transform: rotate(945deg);
  }
  100% {
    transform: rotate(1080deg);
  }
}


@keyframes linear-rotate {
  to {
    transform: rotate(360deg);
  }
}
</style>
''';
  }
}

class _LinearProgressIndicatorFactory {
  static const String _id = 'linear-progress-indicator';
  web.HTMLDivElement? _div;

  _LinearProgressIndicatorFactory() {
    ui_web.platformViewRegistry.registerViewFactory(_id, (int viewId,
        {Object? params}) {
      final paramsParsed = LinearProgressIndicatorParams.fromMap(
          (params as Map).cast<String, dynamic>());
      final div = web.HTMLDivElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..className = 'linear-progress-indicator-$viewId';
      _div = div;
      setContent(
        params: paramsParsed,
        viewId: viewId,
      );
      return div;
    });
  }

  HtmlElementView build({
    required LinearProgressIndicatorParams params,
    required Function(int viewId) onCreated,
  }) {
    return HtmlElementView(
      viewType: _id,
      creationParams: params.toMap(),
      onPlatformViewCreated: onCreated,
    );
  }

  void setContent({
    required LinearProgressIndicatorParams params,
    required int viewId,
  }) {
    print('setting content linear view id: $viewId ');

    final value = params.value;
    final color = params.progressColor;
    final trackColor = params.trackColor;
    final height = params.height;
    final borderRadius = params.borderRadius;
    value != null
        ? _setContentDeterminate(
            color: color,
            trackColor: trackColor,
            height: height,
            borderRadius: borderRadius,
            value: value,
            viewId: viewId,
          )
        : _setContentIndeterminate(
            color: color,
            trackColor: trackColor,
            height: height,
            borderRadius: borderRadius,
            viewId: viewId,
          );
  }

  void _setContentIndeterminate({
    required Color color,
    required Color trackColor,
    required double height,
    required BorderRadius borderRadius,
    required int viewId,
  }) {
    _div?.innerHTML = '''
      ${_generateCss(
      color: color,
      trackColor: trackColor,
      borderRadius: borderRadius,
      height: height,
      viewId: viewId,
    )}
      <div class="progress indeterminate">
        <div class="dots" ?hidden="true"></div>
        <div class="inactive-track" style="transform: scaleX: 100%"></div>
        <div class="bar primary-bar" style="transform: scaleX: 1%">
          <div class="bar-inner"></div>
        </div>
        <div class="bar secondary-bar">
          <div class="bar-inner"></div>
        </div>
      </div>
          ''';
  }

  void _setContentDeterminate({
    required Color color,
    required Color trackColor,
    required double height,
    required BorderRadius borderRadius,
    required double value,
    required int viewId,
  }) {
    final progress = value * 100;
    _div?.innerHTML = '''
    ${_generateCss(color: color, trackColor: trackColor, borderRadius: borderRadius, height: height, viewId: viewId)}
    <div class="progress">
      <div class="dots" ?hidden="true"></div>
      <div class="bar primary-bar" style="transform: scaleX($progress%)">
        <div class="bar-inner"></div>
      </div>
      <div class="bar secondary-bar">
        <div class="bar-inner"></div>
      </div>
    </div>
        ''';
  }

  String _generateCss({
    required Color color,
    required Color trackColor,
    required double height,
    required BorderRadius borderRadius,
    required int viewId,
  }) {
    final rgbColor =
        'rgb(${color.r * 255}, ${color.g * 255}, ${color.b * 255}, ${color.a})';
    final rgbTrackColor =
        'rgb(${trackColor.r * 255}, ${trackColor.g * 255}, ${trackColor.b * 255}, ${trackColor.a})';
    final determinateDuration = Duration(milliseconds: 250);
    final indeterminateDuration = Duration(seconds: 2);
    final determinateEasing = 'cubic-bezier(0.4, 0, 0.6, 1)';
    final svg =
        "data:image/svg+xml,%3Csvg version='1.1' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 5 2' preserveAspectRatio='xMinYMin slice'%3E%3Ccircle cx='1' cy='1' r='1'/%3E%3C/svg%3E";
    final dotSize = height / 2;
    // the amount to animate is aligned with the default track background
    final dotBackgroundWidth = dotSize * 5;

    return '''
<style>
.linear-progress-indicator-$viewId {
  border-radius: ${borderRadius.topLeft}px ${borderRadius.topRight}px ${borderRadius.bottomRight}px ${borderRadius.bottomLeft}px;
  display: flex;
  position: relative;
  /* note, this matches the `meter` element and is just done so there's a default width. */
  min-width: 80px;
  height: ${height}px;
  content-visibility: auto;
  contain: strict;
}

.linear-progress-indicator-$viewId .progress,
.linear-progress-indicator-$viewId .dots,
.linear-progress-indicator-$viewId .inactive-track,
.linear-progress-indicator-$viewId .bar,
.linear-progress-indicator-$viewId .bar-inner {
  position: absolute;
}

.linear-progress-indicator-$viewId .progress {
  /* Animations need to be in LTR. We support RTL by flipping the indicator with scale(-1). */
  direction: ltr;
  inset: 0;
  border-radius: inherit;
  overflow: hidden;
  display: flex;
  align-items: center;
}

.linear-progress-indicator-$viewId .bar {
  animation: none;
  /* position is offset for indeterminate animation, so we lock the inline size here. */
  width: 100%;
  height: 100%;
  transform-origin: left center;
  transition: transform ${determinateDuration.inMilliseconds}ms $determinateEasing;
}

.linear-progress-indicator-$viewId .secondary-bar {
  display: none;
}

.linear-progress-indicator-$viewId .bar-inner {
  inset: 0;
  animation: none;
  background: $rgbColor;
}

.linear-progress-indicator-$viewId .inactive-track {
  background: $rgbTrackColor;
  inset: 0;
  transition: transform ${determinateDuration.inMilliseconds}ms $determinateEasing;
  transform-origin: left center;
}

.linear-progress-indicator-$viewId .dots {
  inset: 0;
  animation: linear infinite ${determinateDuration.inMilliseconds}ms;
  animation-name: buffering;
  /* The color of the buffer dots, which are masked out of this background color. */
  background-color: $rgbTrackColor;
  background-repeat: repeat-x;
  /* SVG is optimized for data URI (https://codepen.io/tigt/post/optimizing-svgs-in-data-uris)
    This svg creates a black circle on a transparent background which is used
    to mask out the animated buffering dots. This technique allows for dot
    color customization via the background-color property, and mask-image
    displays when forced-colors are active. */
  /* required for full support with Chrome, Edge, and Opera. */
  -webkit-mask-image: url($svg);
  mask-image: url($svg);
  z-index: -1; /* Place behind tracks for Safari */
}

/* dots are hidden when indeterminate or when there is no visible buffer to
  prevent infinite invisible animation. */
.linear-progress-indicator-$viewId .dots[hidden] {
  display: none;
}

/* indeterminate */
.linear-progress-indicator-$viewId .indeterminate .bar {
  transition: none;
}

/* note, the numbers here come directly from the mdc implementation.
   see https://github.com/material-components/material-components-web/blob/main/packages/mdc-linear-progress/_linear-progress.scss#L208. */
.linear-progress-indicator-$viewId .indeterminate .primary-bar {
  inset-inline-start: -145.167%;
}

.linear-progress-indicator-$viewId .indeterminate .secondary-bar {
  inset-inline-start: -54.8889%;
  /* this is display none by default. */
  display: block;
}

.linear-progress-indicator-$viewId .indeterminate .primary-bar {
  animation: linear infinite ${indeterminateDuration.inMilliseconds}ms;
  animation-name: primary-indeterminate-translate;
}

.linear-progress-indicator-$viewId .indeterminate .primary-bar > .bar-inner {
  animation: linear infinite ${indeterminateDuration.inMilliseconds}ms
    primary-indeterminate-scale;
}

.linear-progress-indicator-$viewId .indeterminate .secondary-bar {
  animation: linear infinite ${indeterminateDuration.inMilliseconds}ms;
  animation-name: secondary-indeterminate-translate;
}

.linear-progress-indicator-$viewId .indeterminate .secondary-bar > .bar-inner {
  animation: linear infinite ${indeterminateDuration.inMilliseconds}ms
    secondary-indeterminate-scale;
}

:host(:dir(rtl)) {
  transform: scale(-1);
}

@keyframes primary-indeterminate-scale {
  0% {
    transform: scaleX(0.08);
  }

  36.65% {
    animation-timing-function: cubic-bezier(0.334731, 0.12482, 0.785844, 1);
    transform: scaleX(0.08);
  }

  69.15% {
    animation-timing-function: cubic-bezier(0.06, 0.11, 0.6, 1);
    transform: scaleX(0.661479);
  }

  100% {
    transform: scaleX(0.08);
  }
}

@keyframes secondary-indeterminate-scale {
  0% {
    animation-timing-function: cubic-bezier(
      0.205028,
      0.057051,
      0.57661,
      0.453971,
    );
    transform: scaleX(0.08);
  }

  19.15% {
    animation-timing-function: cubic-bezier(
      0.152313,
      0.196432,
      0.648374,
      1.00432
    );
    transform: scaleX(0.457104);
  }

  44.15% {
    animation-timing-function: cubic-bezier(
      0.257759,
      -0.003163,
      0.211762,
      1.38179
    );
    transform: scaleX(0.72796);
  }

  100% {
    transform: scaleX(0.08);
  }
}

@keyframes buffering {
  0% {

    transform: translateX(${dotBackgroundWidth}px);
  }
}

@keyframes primary-indeterminate-translate {
  0% {
    transform: translateX(0px);
  }

  20% {
    animation-timing-function: cubic-bezier(0.5, 0, 0.701732, 0.495819);
    transform: translateX(0px);
  }

  59.15% {
    animation-timing-function: cubic-bezier(
      0.302435,
      0.381352,
      0.55,
      0.956352
    );
    transform: translateX(83.6714%);
  }

  100% {
    transform: translateX(200.611%);
  }
}

@keyframes secondary-indeterminate-translate {
  0% {
    animation-timing-function: cubic-bezier(0.15, 0, 0.515058, 0.409685);
    transform: translateX(0px);
  }

  25% {
    animation-timing-function: cubic-bezier(0.31033, 0.284058, 0.8, 0.733712);
    transform: translateX(37.6519%);
  }

  48.35% {
    animation-timing-function: cubic-bezier(0.4, 0.627035, 0.6, 0.902026);
    transform: translateX(84.3862%);
  }

  100% {
    transform: translateX(160.278%);
  }
}

@media (forced-colors: active) {
  :host {
    outline: 1px solid CanvasText;
  }

  .bar-inner,
  .dots {
    background-color: CanvasText;
  }
}
</style>
''';
  }
}
