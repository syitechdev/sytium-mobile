import CallKit
import Firebase
import FirebaseMessaging
import Flutter
import GoogleMaps
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

    // Google Maps : la cle vient d'Info.plist, alimente par Secrets.xcconfig
    // (hors depot). Sans elle la carte reste grise — d'ou la trace explicite.
    if let apiKey = Bundle.main.object(forInfoDictionaryKey: "GMSApiKey") as? String,
       !apiKey.isEmpty {
      GMSServices.provideAPIKey(apiKey)
    } else {
      NSLog("[AppDelegate] GMSApiKey absente d'Info.plist : Google Maps ne s'affichera pas.")
    }

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

    // Expose l'environnement APNs REEL (cf. apsEnvironment) a Dart, qui le
    // declare au backend pour choisir l'hote APNs des pushs VoIP.
    let channel = FlutterMethodChannel(
      name: "tech.sytium.mobile/provisioning",
      binaryMessenger: engineBridge.applicationRegistrar.messenger()
    )
    channel.setMethodCallHandler { call, result in
      switch call.method {
      case "apsEnvironment":
        result(Self.apsEnvironment())
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }

  // MARK: - Environnement APNs reel

  /// Lit `aps-environment` dans le profil de provisioning embarque.
  ///
  /// C'est la seule source fiable : le mode de compilation ne dit rien du
  /// provisioning. Un build `--release` exporte en developpement ou ad hoc porte
  /// un entitlement `development` et un jeton VoIP SANDBOX ; le declarer
  /// 'production' fait repondre BadDeviceToken a l'APNs, le serveur purge alors
  /// le voip_token et l'iPhone ne sonne plus, appli fermee.
  ///
  /// Une app distribuee par l'App Store ne contient PAS de
  /// `embedded.mobileprovision` : son absence signifie donc production.
  private static func apsEnvironment() -> String {
    guard let url = Bundle.main.url(forResource: "embedded", withExtension: "mobileprovision"),
          let data = try? Data(contentsOf: url),
          // Conteneur CMS signe : le plist XML est encapsule en clair dedans.
          let text = String(data: data, encoding: .isoLatin1),
          let start = text.range(of: "<plist"),
          let end = text.range(of: "</plist>"),
          let plistData = String(text[start.lowerBound..<end.upperBound])
            .data(using: .isoLatin1),
          let plist = try? PropertyListSerialization.propertyList(
            from: plistData, format: nil) as? [String: Any],
          let entitlements = plist["Entitlements"] as? [String: Any],
          let environment = entitlements["aps-environment"] as? String
    else {
      return "production"
    }
    return environment
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
