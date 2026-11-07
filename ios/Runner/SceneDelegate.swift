import Flutter
import UIKit

class SceneDelegate: FlutterSceneDelegate {
  /// Last hinge status: 0 none/unknown, 1 closed, 2 partially open, 3 fully open.
  private var hingeStatus = 0
  private var hingeChannel: FlutterMethodChannel?
  private var hingeInteraction: UIInteraction?

  override func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    super.scene(scene, willConnectTo: session, options: connectionOptions)
    startHingeUpdates()
  }

  /// Reports the hinge state of foldable iPhones (iOS 27.1+) to Dart over
  /// `sprint/hinge`. Devices without a hinge never deliver an update.
  private func startHingeUpdates() {
    guard #available(iOS 27.1, *),
      let controller = window?.rootViewController as? FlutterViewController
    else { return }

    let channel = FlutterMethodChannel(
      name: "sprint/hinge",
      binaryMessenger: controller.binaryMessenger
    )
    hingeChannel = channel
    channel.setMethodCallHandler { [weak self] call, result in
      if call.method == "getStatus" {
        result(self?.hingeStatus ?? 0)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    let interaction = UIHingeInteraction { [weak self] _, update in
      guard let self else { return }
      var status = 0
      if let hinge = update.hinge {
        switch hinge.status {
        case .closed: status = 1
        case .partiallyOpen: status = 2
        case .fullyOpen: status = 3
        default: status = 0
        }
      }
      self.hingeStatus = status
      self.hingeChannel?.invokeMethod("status", arguments: status)
    }
    controller.view.addInteraction(interaction)
    hingeInteraction = interaction
  }
}
