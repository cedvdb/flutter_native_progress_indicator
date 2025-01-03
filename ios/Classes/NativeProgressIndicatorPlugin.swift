import Flutter
import UIKit
import SwiftUI

public class NativeProgressIndicatorPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        registrar.register(
            CircularIndicatorFactory(messenger: registrar.messenger()),
            withId: "native_progress_indicator/circular")
        registrar.register(
            LinearIndicatorFactory(messenger: registrar.messenger()),
            withId: "native_progress_indicator/linear")

    }
}


class CircularIndicatorFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return CircularProgressNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }

    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}


class LinearIndicatorFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return LinearProgressNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }

    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}


class CircularProgressNativeView: FLNativeView {
    
    override init(frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?, binaryMessenger messenger: (any FlutterBinaryMessenger)?) {
        super.init(frame: frame, viewIdentifier: viewId, arguments: args, binaryMessenger: messenger)
        var value: Float?
        var trackColor: Color
        var progressColor: Color
        var strokeWidth: Float
        // Extracting parameters from Flutter arguments,
        // these are the parameters that are send from the Flutter code, using
        // "creationParams" parameter.
        if let params = args as? [String: Any] {
            let trackColorDictionary: Dictionary<String, Double> = params["trackColor"] as! Dictionary
            let progressColorDictionary: Dictionary<String, Double> = params["progressColor"] as! Dictionary
            trackColor = Color(
                red: trackColorDictionary["r"]!,
                green: trackColorDictionary["g"]!,
                blue: trackColorDictionary["b"]!,
                opacity: trackColorDictionary["a"]!)
            progressColor = Color(
                red: progressColorDictionary["r"]!,
                green: progressColorDictionary["g"]!,
                blue: progressColorDictionary["b"]!,
                opacity: progressColorDictionary["a"]!)
            strokeWidth = (params["strokeWidth"] as? NSNumber)?.floatValue ?? 4
            value  = (params["value"] as? NSNumber)?.floatValue
            
        } else {
            trackColor = Color(red: 0, green: 0, blue: 0)
            progressColor = Color(red: 255, green: 255, blue: 255)
            strokeWidth = 4
            value = 0.5
        }

        if let valueNonNull = value {
            createNativeView(
                view: _view,
                indicator: DeterminateCircularProgressIndicator(
                    value: valueNonNull,
                    trackColor: trackColor,
                    progressColor: progressColor,
                    strokeWidth: strokeWidth)
            )
        } else {
            createNativeView(
                view: _view,
                indicator: IndeterminateCircularProgressIndicator(
                    trackColor: trackColor,
                    progressColor: progressColor,
                    strokeWidth: strokeWidth)
            )
        }

    }
}



class LinearProgressNativeView: FLNativeView {
    
    override init(frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?, binaryMessenger messenger: (any FlutterBinaryMessenger)?) {
        super.init(frame: frame, viewIdentifier: viewId, arguments: args, binaryMessenger: messenger)
        var value: Float?
        var trackColor: Color
        var progressColor: Color
        var height: Float
        // Extracting parameters from Flutter arguments,
        // these are the parameters that are send from the Flutter code, using
        // "creationParams" parameter.
        if let params = args as? [String: Any] {
            let trackColorDictionary: Dictionary<String, Double> = params["trackColor"] as! Dictionary
            let progressColorDictionary: Dictionary<String, Double> = params["progressColor"] as! Dictionary
            trackColor = Color(
                red: trackColorDictionary["r"]!,
                green: trackColorDictionary["g"]!,
                blue: trackColorDictionary["b"]!,
                opacity: trackColorDictionary["a"]!)
            progressColor = Color(
                red: progressColorDictionary["r"]!,
                green: progressColorDictionary["g"]!,
                blue: progressColorDictionary["b"]!,
                opacity: progressColorDictionary["a"]!)
            height = (params["height"] as? NSNumber)?.floatValue ?? 4
            value  = (params["value"] as? NSNumber)?.floatValue
            
        } else {
            trackColor = Color(red: 0, green: 0, blue: 0)
            progressColor = Color(red: 255, green: 255, blue: 255)
            height = 4
            value = 0.5
        }

        if let valueNonNull = value {
            createNativeView(
                view: _view,
                indicator: DeterminateLinearProgressIndicator(
                    value: valueNonNull,
                    trackColor: trackColor,
                    progressColor: progressColor,
                    height: height)
            )
        } else {
            createNativeView(
                view: _view,
                indicator: IndeterminateLinearProgressIndicator(
                    trackColor: trackColor,
                    progressColor: progressColor,
                    height: height)
            )
        }

    }
}

class FLNativeView: NSObject, FlutterPlatformView {
    var _view: UIView

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        super.init()
    }

    func view() -> UIView {
        return _view
    }

    func createNativeView(view _view: UIView, indicator: some View){
        _view.backgroundColor = UIColor(white: 0, alpha: 0)

        let keyWindows = UIApplication.shared.windows.first(where: { $0.isKeyWindow}) ?? UIApplication.shared.windows.first
        let topController = keyWindows?.rootViewController
        
        let vc = UIHostingController(
            rootView: indicator)
        let swiftUiView = vc.view!
        swiftUiView.backgroundColor = UIColor(white: 0, alpha: 0)
        swiftUiView.translatesAutoresizingMaskIntoConstraints = false
        
        topController?.addChild(vc)
        _view.addSubview(swiftUiView)
        
        NSLayoutConstraint.activate(
            [
                swiftUiView.leadingAnchor.constraint(equalTo: _view.leadingAnchor),
                swiftUiView.trailingAnchor.constraint(equalTo: _view.trailingAnchor),
                swiftUiView.topAnchor.constraint(equalTo: _view.topAnchor),
                swiftUiView.bottomAnchor.constraint(equalTo:  _view.bottomAnchor)
            ])
        
        vc.didMove(toParent: topController)
    }
}


