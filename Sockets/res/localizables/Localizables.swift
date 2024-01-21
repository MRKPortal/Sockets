// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Ls {
  /// 
  public static let accessServerPlaceholder = Ls.tr("Localizables", "access_server_placeholder", fallback: "Server")
  /// 
  public static let accessUsernamePlaceholder = Ls.tr("Localizables", "access_username_placeholder", fallback: "Username")
  /// 
  public static let actionConnect = Ls.tr("Localizables", "action_connect", fallback: "Connect")
  /// 
  public static let actionEnter = Ls.tr("Localizables", "action_enter", fallback: "Enter")
  /// 
  public static let alertEnterDescription = Ls.tr("Localizables", "alert_enter_description", fallback: "Set an alias for the room.\nProtect it with your password.\nShare it with your friends")
  /// 
  public static let alertEnterTitle = Ls.tr("Localizables", "alert_enter_title", fallback: "Enter to a room")
  /// 
  public static let appName = Ls.tr("Localizables", "app_name", fallback: "Sockets")
  /// 
  public static let chatBannerEncryption = Ls.tr("Localizables", "chat_banner_encryption", fallback: "All messages are encrypted")
  /// 
  public static let chatBannerInvite = Ls.tr("Localizables", "chat_banner_invite", fallback: "Hold on the group name to copy the invitation key and share it.")
  /// 
  public static let chatFeedbackKeyCopied = Ls.tr("Localizables", "chat_feedback_key_copied", fallback: "Private key copied to clipboard!")
  /// 
  public static let createPasswordPlaceholder = Ls.tr("Localizables", "create_password_placeholder", fallback: "Password")
  /// 
  public static let createRoomPlaceholder = Ls.tr("Localizables", "create_room_placeholder", fallback: "Room Name")
  /// 
  public static let genericCancel = Ls.tr("Localizables", "generic_cancel", fallback: "Cancel")
  /// 
  public static func genericConnectedTo(_ p1: Any) -> String {
    return Ls.tr("Localizables", "generic_connected_to", String(describing: p1), fallback: "Connected to:\n%@")
  }
  /// 
  public static let genericConnecting = Ls.tr("Localizables", "generic_connecting", fallback: "Connecting...")
  /// 
  public static let genericDisconnected = Ls.tr("Localizables", "generic_disconnected", fallback: "Disconnected")
  /// 
  public static let genericYes = Ls.tr("Localizables", "generic_yes", fallback: "Yes")
  /// 
  public static let logoutDescription = Ls.tr("Localizables", "logout_description", fallback: "Are you sure you want to leave?")
  /// 
  public static let logoutTitle = Ls.tr("Localizables", "logout_title", fallback: "Close session")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Ls {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
