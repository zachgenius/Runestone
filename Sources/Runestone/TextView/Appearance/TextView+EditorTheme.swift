//
//  TextView+EditorTheme.swift
//  Runestone
//
//  Convenience extension for applying EditorTheme to TextView.
//

import UIKit

public extension TextView {
    /// Applies an `EditorTheme` to the text view, setting all theme-related properties.
    ///
    /// This method sets:
    /// - The base theme (syntax highlighting, gutter colors, etc.)
    /// - Background color
    /// - Insertion point (cursor) color
    /// - Selection bar color
    /// - Selection highlight color
    ///
    /// - Parameter editorTheme: The editor theme to apply.
    func applyTheme(_ editorTheme: EditorTheme) {
        // Apply base theme properties (syntax highlighting, gutter, etc.)
        theme = editorTheme

        // Apply editor appearance properties
        backgroundColor = editorTheme.backgroundColor
        insertionPointColor = editorTheme.insertionPointColor
        selectionBarColor = editorTheme.selectionBarColor
        selectionHighlightColor = editorTheme.selectionHighlightColor
    }

    /// Applies an `EditorTheme` to the text view and returns the recommended user interface style.
    ///
    /// This is useful when you need to update the view controller's preferred status bar style
    /// or other UI elements based on the theme.
    ///
    /// - Parameter editorTheme: The editor theme to apply.
    /// - Returns: The user interface style recommended by the theme.
    @discardableResult
    func applyThemeWithStyle(_ editorTheme: EditorTheme) -> UIUserInterfaceStyle {
        applyTheme(editorTheme)
        return editorTheme.userInterfaceStyle
    }
}
