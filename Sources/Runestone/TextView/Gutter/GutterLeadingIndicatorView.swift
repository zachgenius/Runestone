import UIKit

/// Internal view for rendering gutter leading indicators (breakpoints, arrows, etc.)
final class GutterLeadingIndicatorView: UIView, ReusableView {
    private var indicator: GutterLeadingIndicator?
    private var customView: UIView?

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = .clear
        isUserInteractionEnabled = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with indicator: GutterLeadingIndicator) {
        // Remove previous custom view if any
        customView?.removeFromSuperview()
        customView = nil

        self.indicator = indicator

        switch indicator.type {
        case .custom(let view):
            customView = view
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(view)
        default:
            // Will be drawn in draw(_:)
            break
        }

        setNeedsDisplay()
    }

    func prepareForReuse() {
        customView?.removeFromSuperview()
        customView = nil
        indicator = nil
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        guard let indicator = indicator, let context = UIGraphicsGetCurrentContext() else {
            return
        }

        let size = min(bounds.width - 4, bounds.height - 4)
        let centerX = bounds.midX
        let centerY = bounds.midY

        switch indicator.type {
        case .filledCircle(let color):
            let circleRect = CGRect(
                x: centerX - size / 2,
                y: centerY - size / 2,
                width: size,
                height: size
            )
            context.setFillColor(color.cgColor)
            context.fillEllipse(in: circleRect)

        case .hollowCircle(let color, let lineWidth):
            let inset = lineWidth / 2
            let circleRect = CGRect(
                x: centerX - size / 2 + inset,
                y: centerY - size / 2 + inset,
                width: size - lineWidth,
                height: size - lineWidth
            )
            context.setStrokeColor(color.cgColor)
            context.setLineWidth(lineWidth)
            context.strokeEllipse(in: circleRect)

        case .arrow(let color):
            // Draw right-pointing arrow
            let arrowWidth = size * 0.8
            let arrowHeight = size * 0.6
            let bodyWidth = arrowWidth * 0.5
            let bodyHeight = arrowHeight * 0.4

            context.setFillColor(color.cgColor)

            // Arrow body (rectangle)
            let bodyRect = CGRect(
                x: centerX - arrowWidth / 2,
                y: centerY - bodyHeight / 2,
                width: bodyWidth,
                height: bodyHeight
            )
            context.fill(bodyRect)

            // Arrow head (triangle)
            context.beginPath()
            context.move(to: CGPoint(x: centerX - arrowWidth / 2 + bodyWidth, y: centerY - arrowHeight / 2))
            context.addLine(to: CGPoint(x: centerX + arrowWidth / 2, y: centerY))
            context.addLine(to: CGPoint(x: centerX - arrowWidth / 2 + bodyWidth, y: centerY + arrowHeight / 2))
            context.closePath()
            context.fillPath()

        case .custom:
            // Custom views are handled in configure()
            break
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        customView?.frame = bounds
    }
}
