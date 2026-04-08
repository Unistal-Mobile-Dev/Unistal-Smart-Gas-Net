import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {

  private let CHANNEL = "steelApp"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller = window?.rootViewController as! FlutterViewController

    let channel = FlutterMethodChannel(
        name: CHANNEL,
        binaryMessenger: controller.binaryMessenger
    )

    channel.setMethodCallHandler { (call, result) in
        if call.method == "getAppUpdate" {
            self.checkForUpdate(result: result)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func checkForUpdate(result: @escaping FlutterResult) {

    guard let bundleId = Bundle.main.bundleIdentifier else {
        result(["update": false])
        return
    }

    let urlString = "https://itunes.apple.com/lookup?bundleId=\(bundleId)"

    guard let url = URL(string: urlString) else {
        result(["update": false])
        return
    }

    URLSession.shared.dataTask(with: url) { data, _, error in

        guard let data = data,
              error == nil,
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let results = json["results"] as? [[String: Any]],
              let first = results.first else {

            DispatchQueue.main.async {
                result(["update": false])
            }
            return
        }

        let storeVersion = first["version"] as? String ?? ""
        let appId = first["trackId"] as? Int ?? 0
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""

        let isUpdate = self.isUpdateAvailable(store: storeVersion, current: currentVersion)

        DispatchQueue.main.async {
            result([
                "update": isUpdate,
                "appId": "\(appId)"
            ])
        }

    }.resume()
  }

  private func isUpdateAvailable(store: String, current: String) -> Bool {
      return store.compare(current, options: .numeric) == .orderedDescending
  }
}