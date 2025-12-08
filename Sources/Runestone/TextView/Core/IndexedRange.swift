import UIKit

/// A UITextRange subclass that wraps an NSRange for use with UITextInput methods.
public final class IndexedRange: UITextRange {
    /// The underlying NSRange
    public let range: NSRange

    override public var start: UITextPosition {
        IndexedPosition(index: range.location)
    }

    override public var end: UITextPosition {
        IndexedPosition(index: range.location + range.length)
    }

    override public var isEmpty: Bool {
        range.length == 0
    }

    /// Create an IndexedRange from an NSRange
    public init(_ range: NSRange) {
        self.range = range
    }

    /// Create an IndexedRange from location and length
    public convenience init(location: Int, length: Int) {
        let range = NSRange(location: location, length: length)
        self.init(range)
    }
}
