//
//  EditorTheme.swift
//  Runestone
//
//  Extended theme protocol that includes editor appearance properties
//  not covered by the base Theme protocol.
//

import UIKit

/// An extended theme protocol that includes all editor appearance properties.
///
/// This protocol extends the base `Theme` protocol with additional properties
/// for controlling the editor's background color, cursor colors, and selection colors.
/// These properties are not part of the base Theme protocol but are essential for
/// complete editor theming.
///
/// Example usage:
/// ```swift
/// class MyTheme: EditorTheme {
///     // Required Theme properties...
///
///     var backgroundColor: UIColor { .black }
///     var insertionPointColor: UIColor { .white }
///     var selectionBarColor: UIColor { .white }
///     var selectionHighlightColor: UIColor { .white.withAlphaComponent(0.3) }
///     var userInterfaceStyle: UIUserInterfaceStyle { .dark }
/// }
///
/// // Apply the theme
/// textView.applyTheme(myTheme)
/// ```
public protocol EditorTheme: Theme {
    /// Background color of the text view.
    var backgroundColor: UIColor { get }

    /// Color of the insertion point (text cursor/caret).
    var insertionPointColor: UIColor { get }

    /// Color of the selection bar (the draggable handles on selection).
    var selectionBarColor: UIColor { get }

    /// Color of the text selection highlight.
    var selectionHighlightColor: UIColor { get }

    /// The user interface style to apply when this theme is active.
    /// Used for controlling status bar appearance and system UI elements.
    var userInterfaceStyle: UIUserInterfaceStyle { get }
}

// MARK: - Default Implementations

public extension EditorTheme {
    /// Default insertion point color matches the text color.
    var insertionPointColor: UIColor {
        textColor
    }

    /// Default selection bar color matches the text color.
    var selectionBarColor: UIColor {
        textColor
    }

    /// Default selection highlight color is text color with transparency.
    var selectionHighlightColor: UIColor {
        textColor.withAlphaComponent(0.3)
    }

    /// Default user interface style is based on background color brightness.
    var userInterfaceStyle: UIUserInterfaceStyle {
        // Determine if background is light or dark based on luminance
        var white: CGFloat = 0
        backgroundColor.getWhite(&white, alpha: nil)
        return white > 0.5 ? .light : .dark
    }
}
