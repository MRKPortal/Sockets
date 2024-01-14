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
  public static let appName = Ls.tr("Localizables", "app_name", fallback: "Sockets")
  /// 
  public static let chatBannerEncryption = Ls.tr("Localizables", "chat_banner_encryption", fallback: "All messages are encrypted")
  /// 
  public static let chatBannerInvite = Ls.tr("Localizables", "chat_banner_invite", fallback: "Hold on the group name to copy the invitation key and share it.")
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
