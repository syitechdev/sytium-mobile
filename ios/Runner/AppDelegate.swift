import CallKit
import Firebase
import FirebaseMessaging
import Flutter
import PushKit
import UIKit
import flutter_callkit_incoming

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate, PKPushRegistryDelegate {
  private var voipRegistry: PKPushRegistry?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Firebase lit GoogleService-Info.plist ; permet FCM (alertes + Android).
    FirebaseApp.configure()

    // PushKit VoIP : le seul canal fiable pour réveiller une app tuée sur un
    // appel entrant (iOS refuse les FCM data-only en arrière-plan pour ça).
    let registry = PKPushRegistry(queue: .main)
    registry.delegate = self
    registry.desiredPushTypes = [.voIP]
    voipRegistry = registry

    // APNs (pour les notifications FCM classiques : messages, etc.).
    application.registerForRemoteNotifications()

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }

  // MARK: - APNs (FCM)

  override func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Foundation.Data
  ) {
    // Transmet le token APNs à Firebase pour la livraison des notifications FCM.
    Messaging.messaging().apnsToken = deviceToken
    super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
  }

  // MARK: - PushKit (VoIP) → CallKit

  func pushRegistry(
    _ registry: PKPushRegistry,
    didUpdate pushCredentials: PKPushCredentials,
    for type: PKPushType
  ) {
    guard type == .voIP else { return }
    let token = pushCredentials.token.map { String(format: "%02x", $0) }.joined()
    // Le plugin relaie ce token à Dart (event actionDidUpdateDevicePushTokenVoip),
    // qui l'enregistre alors comme voip_token côté backend.
    SwiftFlutterCallkitIncomingPlugin.sharedInstance?.setDevicePushTokenVoIP(token)
  }

  func pushRegistry(
    _ registry: PKPushRegistry,
    didInvalidatePushTokenFor type: PKPushType
  ) {
    guard type == .voIP else { return }
    SwiftFlutterCallkitIncomingPlugin.sharedInstance?.setDevicePushTokenVoIP("")
  }

  func pushRegistry(
    _ registry: PKPushRegistry,
    didReceiveIncomingPushWith payload: PKPushPayload,
    for type: PKPushType,
    completion: @escaping () -> Void
  ) {
    guard type == .voIP else { completion(); return }

    let info = payload.dictionaryPayload
    let callId = string(info["call_id"])
    let callerName = string(info["caller_name"]).isEmpty ? "Appel entrant" : string(info["caller_name"])
    let kind = string(info["kind"]).isEmpty ? string(info["call_type"]) : string(info["kind"])
    let isVideo = kind == "video"

    // iOS 13+ EXIGE de reporter un appel pour chaque push VoIP reçu, sinon
    // l'app est tuée et bannie des futurs VoIP. On utilise le call_id backend
    // comme id CallKit (déjà un UUID) pour un mapping direct à l'accept.
    let data = flutter_callkit_incoming.Data(
      id: callId,
      nameCaller: callerName,
      handle: callerName,
      type: isVideo ? 1 : 0
    )
    data.appName = "Sytium"
    data.extra = [
      "call_id": callId,
      "channel_id": string(info["channel_id"]),
      "kind": isVideo ? "video" : "audio",
      "caller_name": callerName,
    ]

    SwiftFlutterCallkitIncomingPlugin.sharedInstance?.showCallkitIncoming(data, fromPushKit: true)
    completion()
  }

  private func string(_ value: Any?) -> String {
    if let s = value as? String { return s }
    if let n = value as? NSNumber { return n.stringValue }
    return ""
  }
}
