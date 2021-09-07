// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Localization {
  /// N/A
  internal static let listEmptyInfo = Localization.tr("Localizable", "list_empty_info")
  /// %@ g
  internal static func listMass(_ p1: Any) -> String {
    return Localization.tr("Localizable", "list_mass", String(describing: p1))
  }
  /// List
  internal static let listTitle = Localization.tr("Localizable", "list_title")
  /// Map
  internal static let mapTitle = Localization.tr("Localizable", "map_title")
  /// Class
  internal static let sortClass = Localization.tr("Localizable", "sort_class")
  /// Date
  internal static let sortDate = Localization.tr("Localizable", "sort_date")
  /// Location
  internal static let sortLocation = Localization.tr("Localizable", "sort_location")
  /// Mass
  internal static let sortMass = Localization.tr("Localizable", "sort_mass")
  /// Name
  internal static let sortName = Localization.tr("Localizable", "sort_name")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localization {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
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
