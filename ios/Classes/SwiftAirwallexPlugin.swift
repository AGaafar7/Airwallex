import Flutter
import UIKit
import Airwallex 
//TODO: add the initialize and getBaseUrl functions
class AirwallexApi{
  /*func initialize(){
    
  }*/
}
public class SwiftAirwallexPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "airwallex", binaryMessenger: registrar.messenger())
    let instance = SwiftAirwallexPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch(call.method) {
      case "initialize": 
        result("Not Implemented Yet. Will support it soon")
      case "getBaseUrl":
        result("Not Implemented Yet. Will support it soon")
      default: 
        result(FlutterMethodNotImplemented)
    }
    result("iOS " + UIDevice.current.systemVersion)
  }
}
