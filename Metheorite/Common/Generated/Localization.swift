// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Localization {
  /// Full article
  internal static let newsDetailsFullArticleButton = Localization.tr("Localizable", "news_details_full_article_button")
  /// ¬
  internal static let newsDetailsSeparator = Localization.tr("Localizable", "news_details_separator")
  /// Share
  internal static let newsDetailsShareButton = Localization.tr("Localizable", "news_details_share_button")
  /// Search here
  internal static let newsListSearchPlaceholder = Localization.tr("Localizable", "news_list_search_placeholder")
  /// News
  internal static let newsListTabItem = Localization.tr("Localizable", "news_list_tab_item")
  /// Front page
  internal static let newsListTitle = Localization.tr("Localizable", "news_list_title")
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
