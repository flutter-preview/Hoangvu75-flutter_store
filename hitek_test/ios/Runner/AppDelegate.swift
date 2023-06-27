import UIKit
import Flutter
import Network

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var flutterIosChannel: FlutterMethodChannel?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        flutterIosChannel = FlutterMethodChannel(name: "native_ios_channel", binaryMessenger: controller.binaryMessenger)
        
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            var isConnected = path.status == .satisfied
            Task {
                await MainActor.run {
                    self.flutterIosChannel?.invokeMethod("internet_connection", arguments: isConnected)
                }
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
