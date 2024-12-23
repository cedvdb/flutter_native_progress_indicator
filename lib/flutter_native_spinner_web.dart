// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'dart:ui_web' as ui_web;

import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web/web.dart' as web;

import 'flutter_native_spinner_platform_interface.dart';

/// A web implementation of the FlutterNativeSpinnerPlatform of the FlutterNativeSpinner plugin.
class FlutterNativeSpinnerWeb extends FlutterNativeSpinnerPlatform {
  /// Constructs a FlutterNativeSpinnerWeb
  FlutterNativeSpinnerWeb();

  static void registerWith(Registrar registrar) {
    FlutterNativeSpinnerPlatform.instance = FlutterNativeSpinnerWeb();
  }

  @override
  Widget buildIndeterminateCircularProgressIndicator({
    required Color color,
    required Color trackColor,
    required double strokeWidth,
  }) =>
      _CircularProgressIndicatorBuilder().indeterminate(
          color: color, strokeWidth: strokeWidth, trackColor: trackColor);

  @override
  Widget buildDeterminateCircularProgressIndicator({
    required Color color,
    required Color trackColor,
    required double strokeWidth,
    required double value,
  }) =>
      _CircularProgressIndicatorBuilder().determinate(
          color: color,
          strokeWidth: strokeWidth,
          value: value,
          trackColor: trackColor);

  @override
  Widget buildIndeterminateLinearProgressIndicator({
    required Color color,
    required Color trackColor,
    required double height,
    required BorderRadius borderRadius,
  }) =>
      _LinearProgressIndicatorBuilder().indeterminate(
        color: color,
        trackColor: trackColor,
        borderRadius: borderRadius,
        height: height,
      );

  @override
  Widget buildDeterminateLinearProgressIndicator({
    required Color color,
    required double strokeWidth,
    required double value,
  }) {
    throw UnimplementedError();
  }
}

class _CircularProgressIndicatorBuilder {
  Widget indeterminate({
    required Color color,
    required Color trackColor,
    required double strokeWidth,
  }) {
    final div = HtmlElementView.fromTagName(
      tagName: 'div',
      onElementCreated: (Object div) {
        div as web.HTMLDivElement;
        div.style.width = '100%';
        div.style.height = '100%';
        div.className = 'host progress indeterminate';
        div.innerHTML = '''
          ${generateCss(strokeWidth: strokeWidth, color: color, trackColor: trackColor)}
          <div class="spinner">
            <div class="left">
              <div class="circle"></div>
            </div>
            <div class="right">
              <div class="circle"></div>
            </div>
          </div>
          ''';
      },
    );
    ui_web.platformViewRegistry.registerViewFactory(
      'plugins.flutter.native.io/spinner',
      (int viewId) => div,
    );
    return div;
  }

  Widget determinate({
    required Color color,
    required Color trackColor,
    required double strokeWidth,
    required double value,
  }) {
    final dashOffset = (1 - value) * 100;
    final div = HtmlElementView.fromTagName(
      tagName: 'div',
      onElementCreated: (Object div) {
        div as web.HTMLDivElement;
        div.style.width = '100%';
        div.style.height = '100%';
        div.className = 'host progress';
        div.innerHTML = '''
          ${generateCss(strokeWidth: strokeWidth, color: color, trackColor: trackColor)}
          <svg viewBox="0 0 4800 4800">
            <circle class="track" pathLength="100"></circle>
            <circle
              class="active-track"
              pathLength="100"
              stroke-dashoffset=$dashOffset></circle>
          </svg>
          ''';
      },
    );
    ui_web.platformViewRegistry.registerViewFactory(
      'plugins.flutter.native.io/spinner',
      (int viewId) => div,
    );
    return div;
  }

// styles from https://github.com/material-components/material-web/blob/main/progress/internal/_circular-progress.scss
  String generateCss({
    required double strokeWidth,
    required Color color,
    required Color trackColor,
  }) {
    final arcDuration = Duration(milliseconds: 1337);
    final linearRotateDuration =
        Duration(milliseconds: (1337 * 360 / 306).toInt());
    final cycleDuration = Duration(milliseconds: 1337 * 4);
    final indeterminateEasing = 'cubic-bezier(0.4, 0, 0.2, 1)';
    final rgbColor =
        'rgb(${color.r * 255}, ${color.g * 255}, ${color.b * 255})';
    final rgbTrackColor =
        'rgb(${trackColor.r * 255}, ${trackColor.g * 255}, ${trackColor.b * 255})';

    return '''
<style>

.host {
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


.progress {
  flex: 1;
  align-self: stretch;
}

.progress,
.spinner,
.left,
.right,
.circle,
svg,
.track,
.active-track{
  position: absolute;
  inset: 0;
}

svg {
  transform: rotate(-90deg);
}

circle {
  cx: 50%;
  cy: 50%;
  r: calc(50% * (1 - $strokeWidth / 100));
  stroke-width: calc($strokeWidth * 1%);
  stroke-dasharray: 100;
  fill: transparent;
}

.active-track {
  transition: stroke-dashoffset 500ms cubic-bezier(0, 0, 0.2, 1);
  stroke: $rgbColor;
}

.track {
  stroke: $rgbTrackColor;
}

.progress.indeterminate {
  animation: linear infinite linear-rotate;
  animation-duration: ${linearRotateDuration.inMilliseconds}ms;
}

.spinner {
  animation: infinite both rotate-arc;
  animation-duration: ${cycleDuration.inMilliseconds}ms;
  animation-timing-function: $indeterminateEasing;
}

.left {
  overflow: hidden;
  inset: 0 50% 0 0;
}

.right {
  overflow: hidden;
  inset: 0 0 0 50%;
}

.circle {
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

.four-color .circle {
  animation-name: expand-arc, four-color;
}

.left .circle {
  rotate: 135deg;
  inset: 0 -100% 0 0;
}
.right .circle {
  rotate: 100deg;
  inset: 0 0 0 -100%;
  animation-delay: calc(-0.5 * ${arcDuration.inMilliseconds}ms), 0ms;
}

@media (forced-colors: active) {
  .active-track {
    stroke: CanvasText;
  }

  .circle {
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

class _LinearProgressIndicatorBuilder {
  Widget indeterminate({
    required Color color,
    required Color trackColor,
    required double height,
    required BorderRadius borderRadius,
  }) {
    final div = HtmlElementView.fromTagName(
      tagName: 'div',
      onElementCreated: (Object div) {
        div as web.HTMLDivElement;
        div.style.width = '100%';
        div.style.height = '100%';
        div.className = 'host progress';
        div.innerHTML = '''
      ${generateCss(
          color: color,
          trackColor: trackColor,
          borderRadius: borderRadius,
          height: height,
        )}
      <div class="dots" ?hidden="true"></div>
      <div class="inactive-track" style="transform: scaleX: 100%"></div>
      <div class="bar primary-bar" style="transform: scaleX: 1%">
        <div class="bar-inner"></div>
      </div>
      <div class="bar secondary-bar">
        <div class="bar-inner"></div>
      </div>
          ''';
      },
    );
    ui_web.platformViewRegistry.registerViewFactory(
      'plugins.flutter.native.io/spinner',
      (int viewId) => div,
    );
    return div;
  }

  Widget determinate({
    required Color color,
    required Color trackColor,
    required double strokeWidth,
    required double value,
    required double height,
    required BorderRadius borderRadius,
  }) {
    throw UnimplementedError(
        'buildIndeterminateCircularProgressIndicator() has not been implemented.');
  }

  String generateCss({
    required Color color,
    required Color trackColor,
    required double height,
    required BorderRadius borderRadius,
  }) {
    final rgbColor =
        'rgb(${color.r * 255}, ${color.g * 255}, ${color.b * 255})';
    final rgbTrackColor =
        'rgb(${trackColor.r * 255}, ${trackColor.g * 255}, ${trackColor.b * 255})';
    final determinateDuration = Duration(milliseconds: 250);
    final indeterminateDuration = Duration(milliseconds: 2);
    final determinateEasing = 'cubic-bezier(0.4, 0, 0.6, 1)';
    final svg =
        "data:image/svg+xml,%3Csvg version='1.1' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 5 2' preserveAspectRatio='xMinYMin slice'%3E%3Ccircle cx='1' cy='1' r='1'/%3E%3C/svg%3E";
    final dotSize = height / 2;
    // the amount to animate is aligned with the default track background
    final dotBackgroundWidth = dotSize * 5;

    return '''
<style>
.host {
  border-radius: ${borderRadius.topLeft}px ${borderRadius.topRight}px ${borderRadius.bottomRight}px ${borderRadius.bottomLeft}px;
  display: flex;
  position: relative;
  /* note, this matches the `meter` element and is just done so there's a default width. */
  min-width: 80px;
  height: ${height}px;
  content-visibility: auto;
  contain: strict;
}

.progress,
.dots,
.inactive-track,
.bar,
.bar-inner {
  position: absolute;
}

.progress {
  /* Animations need to be in LTR. We support RTL by flipping the indicator with scale(-1). */
  direction: ltr;
  inset: 0;
  border-radius: inherit;
  overflow: hidden;
  display: flex;
  align-items: center;
}

.bar {
  animation: none;
  /* position is offset for indeterminate animation, so we lock the inline size here. */
  width: 100%;
  height: ${height}px;
  transform-origin: left center;
  transition: transform ${determinateDuration.inMilliseconds}ms $determinateEasing;
}

.secondary-bar {
  display: none;
}

.bar-inner {
  inset: 0;
  animation: none;
  background: $rgbColor;
}

.inactive-track {
  background: $rgbTrackColor;
  inset: 0;
  transition: transform ${determinateDuration.inMilliseconds}ms $determinateEasing;
  transform-origin: left center;
}

.dots {
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
.dots[hidden] {
  display: none;
}

/* indeterminate */
.indeterminate .bar {
  transition: none;
}

/* note, the numbers here come directly from the mdc implementation.
   see https://github.com/material-components/material-components-web/blob/main/packages/mdc-linear-progress/_linear-progress.scss#L208. */
.indeterminate .primary-bar {
  inset-inline-start: -145.167%;
}

.indeterminate .secondary-bar {
  inset-inline-start: -54.8889%;
  /* this is display none by default. */
  display: block;
}

.indeterminate .primary-bar {
  animation: linear infinite ${indeterminateDuration.inMilliseconds}ms;
  animation-name: primary-indeterminate-translate;
}

.indeterminate .primary-bar > .bar-inner {
  animation: linear infinite ${indeterminateDuration.inMilliseconds}ms
    primary-indeterminate-scale;
}

.indeterminate.four-color .primary-bar > .bar-inner {
  animation-name: primary-indeterminate-scale, four-color;
  animation-duration:${indeterminateDuration.inMilliseconds}ms,
    calc(${indeterminateDuration.inMilliseconds}ms * 2);
}

.indeterminate .secondary-bar {
  animation: linear infinite ${indeterminateDuration.inMilliseconds}ms;
  animation-name: secondary-indeterminate-translate;
}

.indeterminate .secondary-bar > .bar-inner {
  animation: linear infinite ${indeterminateDuration.inMilliseconds}ms
    secondary-indeterminate-scale;
}

.indeterminate.four-color .secondary-bar > .bar-inner {
  animation-name: secondary-indeterminate-scale, four-color;
  animation-duration: ${indeterminateDuration.inMilliseconds}ms,
    calc(${indeterminateDuration.inMilliseconds}ms * 2);
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
