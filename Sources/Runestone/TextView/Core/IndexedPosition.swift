import UIKit

/// A UITextPosition subclass that wraps an integer index.
public final class IndexedPosition: UITextPosition {
    /// The character index in the text
    public let index: Int

    /// Create an IndexedPosition at the given index
    public init(index: Int) {
        self.index = index
    }
}
