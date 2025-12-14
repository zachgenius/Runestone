import Foundation

public final class TimedUndoManager: UndoManager {
    private let endGroupingInterval: TimeInterval = 1
    private var endGroupingTimer: Timer?
    private var hasOpenGroup: Bool {
        groupingLevel > 0
    }

    override public init() {
        super.init()
        groupsByEvent = false
    }

    override public func removeAllActions() {
        cancelTimer()
        super.removeAllActions()
    }

    override public func beginUndoGrouping() {
        if !hasOpenGroup {
            super.beginUndoGrouping()
            if endGroupingTimer == nil {
                scheduleTimer()
            }
        }
    }

    override public func endUndoGrouping() {
        cancelTimer()
        if hasOpenGroup {
            super.endUndoGrouping()
        }
    }

    override public func undo() {
        endUndoGrouping()
        super.undo()
    }
}

private extension TimedUndoManager {
    private func scheduleTimer() {
        let timer = Timer(timeInterval: endGroupingInterval, target: self, selector: #selector(timerDidTrigger), userInfo: nil, repeats: false)
        endGroupingTimer = timer
        RunLoop.main.add(timer, forMode: .common)
    }

    private func cancelTimer() {
        endGroupingTimer?.invalidate()
        endGroupingTimer = nil
    }

    @objc private func timerDidTrigger() {
        cancelTimer()
        endUndoGrouping()
    }
}
