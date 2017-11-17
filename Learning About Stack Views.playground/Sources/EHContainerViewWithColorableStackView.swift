import UIKit

public class EHContainerViewWithColorableStackView: UIView {

    // MARK: - Public properties and methods

    public enum PinningType {
        case begin
        case end
        case center
        case beginAndEnd
    }

    public let stackView = UIStackView(frame: .zero)

    public class func containerWithDoublyCenteredHorizontalStackView() -> EHContainerViewWithColorableStackView {
        let frame = CGRect(origin: .zero, size: EHContainerViewWithColorableStackView.containerViewSize)
        return EHContainerViewWithColorableStackView(frame: frame, vertical: false, pinningAxisDirection: .center, pinningFillDirection: .center)
    }

    public class func containerWithDoublyCenteredVerticalStackView() -> EHContainerViewWithColorableStackView {
        let frame = CGRect(origin: .zero, size: EHContainerViewWithColorableStackView.containerViewSize)
        return EHContainerViewWithColorableStackView(frame: frame, vertical: true, pinningAxisDirection: .center, pinningFillDirection: .center)
    }

    public class func containerWithFixedHorizontalStackView() -> EHContainerViewWithColorableStackView {
        let frame = CGRect(origin: .zero, size: EHContainerViewWithColorableStackView.containerViewSize)
        return EHContainerViewWithColorableStackView(frame: frame, vertical: false, pinningAxisDirection: .beginAndEnd, pinningFillDirection: .center)
    }

    public class func containerWithFixedVerticalStackView() -> EHContainerViewWithColorableStackView {
        let frame = CGRect(origin: .zero, size: EHContainerViewWithColorableStackView.containerViewSize)
        return EHContainerViewWithColorableStackView(frame: frame, vertical: true, pinningAxisDirection: .beginAndEnd, pinningFillDirection: .center)
    }

    private let stackViewBackgroundView = UIView(frame: .zero)
    private static let containerViewSize = CGSize(width: 512.0, height: 512.0)

    public init(frame: CGRect, vertical: Bool, pinningAxisDirection: PinningType, pinningFillDirection: PinningType) {
        super.init(frame: frame)

        backgroundColor = UIColor.lightGray
        stackViewBackgroundView.backgroundColor = UIColor.darkGray


        stackViewBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = (vertical ? UILayoutConstraintAxis.vertical : UILayoutConstraintAxis.horizontal)

        // We add the background view first so that it will be BELOW the stack view
        addSubview(stackViewBackgroundView)
        addSubview(stackView)

        // Pin the stack view
        if vertical {
            pinVertical(pinningType: pinningAxisDirection)
            pinHorizontal(pinningType: pinningFillDirection)
        } else {
            pinHorizontal(pinningType: pinningAxisDirection)
            pinVertical(pinningType: pinningFillDirection)
        }

        // Pin the stack view background to the stack view
        stackViewBackgroundView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        stackViewBackgroundView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        stackViewBackgroundView.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        stackViewBackgroundView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func pinHorizontal(pinningType: PinningType) {
        switch pinningType {
            case .begin:
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            case .end:
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            case .beginAndEnd:
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            case .center:
                stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        }
    }

    private func pinVertical(pinningType: PinningType) {
        switch pinningType {
            case .begin:
                stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            case .end:
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            case .beginAndEnd:
                stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            case .center:
                stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        }
    }

}

