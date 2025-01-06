import Flutter
import UIKit
import SwiftUI

public class NativeProgressIndicatorPlugin: NSObject, FlutterPlugin {
    private var circularIndicatorFactory: CircularIndicatorFactory
    private var linearIndicatorFactory: LinearIndicatorFactory
    
    init(_ circularIndicatorFactory: CircularIndicatorFactory, _ linearIndicatorFactory: LinearIndicatorFactory) {
        self.circularIndicatorFactory = circularIndicatorFactory
        self.linearIndicatorFactory = linearIndicatorFactory
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "native_progress_indicator", binaryMessenger: registrar.messenger())
        let instance = NativeProgressIndicatorPlugin(
            CircularIndicatorFactory(messenger: registrar.messenger()),
            LinearIndicatorFactory(messenger: registrar.messenger())
        )
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        registrar.register(
            instance.circularIndicatorFactory,
            withId: "native_progress_indicator/circular")
        registrar.register(
            instance.linearIndicatorFactory,
            withId: "native_progress_indicator/linear")
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let viewId = args["viewId"] as? Int64 else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid or missing arguments", details: nil))
            return
        }
        
        let params = args["params"] as? [String: Any] ?? [:]
        
        switch call.method {
        case "updateCircularIndicator":
            circularIndicatorFactory.update(viewId: viewId, params: params)
        case "updateLinearIndicator":
            linearIndicatorFactory.update(viewId: viewId, params: params)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    
    class CircularIndicatorFactory: NSObject, FlutterPlatformViewFactory {
        private var messenger: FlutterBinaryMessenger
        private var views: [Int64: CircularProgressNativeView] = [:]
        
        init(messenger: FlutterBinaryMessenger) {
            self.messenger = messenger
            super.init()
        }
        
        func create(
            withFrame frame: CGRect,
            viewIdentifier viewId: Int64,
            arguments args: Any?
        ) -> FlutterPlatformView {
            let view = CircularProgressNativeView(
                frame: frame,
                viewIdentifier: viewId,
                arguments: args,
                binaryMessenger: messenger)
            views[viewId] = view
            return view;
        }
        
        func update(viewId: Int64, params: [String: Any]) {
            views[viewId]?.updateView(params: params)
        }
        
        /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
        public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
            return FlutterStandardMessageCodec.sharedInstance()
        }
    }
    
    
    class LinearIndicatorFactory: NSObject, FlutterPlatformViewFactory {
        private var messenger: FlutterBinaryMessenger
        private var views: [Int64: LinearProgressNativeView] = [:]
        
        init(messenger: FlutterBinaryMessenger) {
            self.messenger = messenger
            super.init()
        }
        
        func create(
            withFrame frame: CGRect,
            viewIdentifier viewId: Int64,
            arguments args: Any?
        ) -> FlutterPlatformView {
            let view = LinearProgressNativeView(
                frame: frame,
                viewIdentifier: viewId,
                arguments: args,
                binaryMessenger: messenger
            )
            views[viewId] = view
            return view;
        }
        
        func update(viewId: Int64, params: [String: Any]) {
            views[viewId]?.updateView(params: params)
        }
        
        /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
        public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
            return FlutterStandardMessageCodec.sharedInstance()
        }
    }
    
    
    class CircularProgressNativeView: FLNativeView {
        let hostingController: UIHostingController<AnyView>
        
        override init(frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?, binaryMessenger messenger: (any FlutterBinaryMessenger)?) {
            let indicator: CircularProgressIndicator
            if let args = args as? [String: Any] {
                indicator = CircularProgressIndicator(params: args)
            } else {
                indicator = CircularProgressIndicator(params: [:])
            }
            hostingController = UIHostingController(rootView: AnyView(indicator))
            super.init(frame: frame, viewIdentifier: viewId, arguments: args, binaryMessenger: messenger)
            configureController(view: _view, hostingController: hostingController)
        }
        
        
        func updateView(params: [String: Any]) {
            let indicator = CircularProgressIndicator(params: params)
            hostingController.rootView = AnyView(indicator)
        }
    }
    
    
    
    class LinearProgressNativeView: FLNativeView {
        let hostingController: UIHostingController<AnyView>
        
        override init(frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?, binaryMessenger messenger: (any FlutterBinaryMessenger)?) {
            let indicator: LinearProgressIndicator
            if let args = args as? [String: Any] {
                indicator = LinearProgressIndicator(params: args)
            } else {
                indicator = LinearProgressIndicator(params: [:])
            }
            hostingController = UIHostingController(rootView: AnyView(indicator))
            super.init(frame: frame, viewIdentifier: viewId, arguments: args, binaryMessenger: messenger)
            configureController(view: _view, hostingController: hostingController)
        }
        
        func updateView(params: [String: Any]) {
            let indicator = LinearProgressIndicator(params: params)
            hostingController.rootView = AnyView(indicator)
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
        
        func configureController(view _view: UIView, hostingController: UIHostingController<AnyView>){
            _view.backgroundColor = UIColor(white: 0, alpha: 0)
            let keyWindows = UIApplication.shared.windows.first(where: { $0.isKeyWindow}) ?? UIApplication.shared.windows.first
            let topController = keyWindows?.rootViewController
            
            let swiftUiView = hostingController.view!
            swiftUiView.backgroundColor = UIColor(white: 0, alpha: 0)
            swiftUiView.translatesAutoresizingMaskIntoConstraints = false
            
            topController?.addChild(hostingController)
            _view.addSubview(swiftUiView)
            
            NSLayoutConstraint.activate(
                [
                    swiftUiView.leadingAnchor.constraint(equalTo: _view.leadingAnchor),
                    swiftUiView.trailingAnchor.constraint(equalTo: _view.trailingAnchor),
                    swiftUiView.topAnchor.constraint(equalTo: _view.topAnchor),
                    swiftUiView.bottomAnchor.constraint(equalTo:  _view.bottomAnchor)
                ])
            
            hostingController.didMove(toParent: topController)
        }
    }
}
