import UIKit

/// Configuration for a gutter leading indicator
public struct GutterLeadingIndicator {
    /// The type of indicator to display
    public enum IndicatorType {
        /// A filled circle (e.g., enabled breakpoint)
        case filledCircle(color: UIColor)
        /// A hollow circle (e.g., disabled breakpoint)
        case hollowCircle(color: UIColor, lineWidth: CGFloat)
        /// An arrow pointing right (e.g., current debug line)
        case arrow(color: UIColor)
        /// A custom view provided by the caller
        case custom(view: UIView)
    }

    /// The 1-indexed line number this indicator is for
    public let lineNumber: Int

    /// The type of indicator to display
    public let type: IndicatorType

    public init(lineNumber: Int, type: IndicatorType) {
        self.lineNumber = lineNumber
        self.type = type
    }
}

/// Protocol for providing custom views in the gutter leading area (left of line numbers).
/// This is useful for displaying breakpoint indicators, bookmarks, or other line annotations.
public protocol GutterLeadingViewProvider: AnyObject {
    /// The width of the leading indicator area. Return 0 to disable.
    var gutterLeadingIndicatorWidth: CGFloat { get }

    /// Called when the text view needs indicators for the visible lines.
    /// - Parameters:
    ///   - textView: The text view requesting indicators
    ///   - lineNumbers: The 1-indexed line numbers currently visible
    /// - Returns: An array of indicators to display. Only provide indicators for lines that need them.
    func textView(_ textView: TextView, indicatorsForVisibleLines lineNumbers: [Int]) -> [GutterLeadingIndicator]

    /// Called when a user taps in the gutter leading area.
    /// - Parameters:
    ///   - textView: The text view where the tap occurred
    ///   - lineNumber: The 1-indexed line number that was tapped
    func textView(_ textView: TextView, didTapGutterLeadingAreaForLine lineNumber: Int)

    /// Called when a user long-presses in the gutter leading area.
    /// - Parameters:
    ///   - textView: The text view where the long press occurred
    ///   - lineNumber: The 1-indexed line number that was long-pressed
    func textView(_ textView: TextView, didLongPressGutterLeadingAreaForLine lineNumber: Int)
}

// Default implementations
public extension GutterLeadingViewProvider {
    func textView(_ textView: TextView, didTapGutterLeadingAreaForLine lineNumber: Int) {}
    func textView(_ textView: TextView, didLongPressGutterLeadingAreaForLine lineNumber: Int) {}
}
