import Flutter
import UIKit
import CoreTelephony

public class FlutterSimCheckPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_sim_check", binaryMessenger: registrar.messenger())
        let instance = FlutterSimCheckPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "getSimInfo" {
            result(getSimInfo())
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    private func getSimInfo() -> [String: Any] {
        var info: [String: Any] = [:]
        let networkInfo = CTTelephonyNetworkInfo()
        if let providers = networkInfo.serviceSubscriberCellularProviders {
            for (_, carrier) in providers {
                let hasSim = carrier.isoCountryCode != nil
                info["hasSimCard"] = hasSim
                info["carrierName"] = carrier.carrierName
                info["mcc"] = carrier.mobileCountryCode
                info["mnc"] = carrier.mobileNetworkCode
                return info
            }
        }
        info["hasSimCard"] = false
        return info
    }
}
