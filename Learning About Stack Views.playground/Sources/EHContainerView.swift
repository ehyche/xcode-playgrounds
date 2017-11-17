import UIKit

public class EHAdjustableContainerView: UIView {

    // MARK: - Public properties

    public let containerView = UIView(frame: .zero)

    // MARK: - Private properties

    private let stackView = UIStackView(frame: .zero)
    private let upperContainerView = UIView(frame: .zero)
    private let containerSizeInfoView = EHContainerSizeInfoView(frame: .zero)
    private var containerViewWidthConstraint = NSLayoutConstraint()
    private var containerViewHeightConstraint = NSLayoutConstraint()
    private let containerViewMargin: CGFloat = 10.0
    private let containerViewMinSize = CGSize(width: 40.0, height: 40.0)

    // MARK: - Initializers

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIView methods

    override public func layoutSubviews() {
        super.layoutSubviews()

        let upperContainerViewSize = upperContainerView.frame.size
        let doubleMargin = containerViewMargin * 2.0
        let containerViewMaxSize = CGSize(width: upperContainerViewSize.width - doubleMargin,
                                          height: upperContainerViewSize.height - doubleMargin)
        containerSizeInfoView.maxContainerSize = containerViewMaxSize
    }

    // MARK: - Private methods

    func setupView() {
        upperContainerView.translatesAutoresizingMaskIntoConstraints = false

        containerView.translatesAutoresizingMaskIntoConstraints = false
        upperContainerView.addSubview(containerView)

        containerView.centerXAnchor.constraint(equalTo: upperContainerView.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: upperContainerView.centerYAnchor).isActive = true

        containerViewWidthConstraint = containerView.widthAnchor.constraint(equalToConstant: 0.0)
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: 0.0)

        containerSizeInfoView.translatesAutoresizingMaskIntoConstraints = false
        containerSizeInfoView.minContainerSize = containerViewMinSize
        containerSizeInfoView.sizeDidChange = {[weak self] (containerSize: CGSize) in
            self?.containerViewWidthConstraint.constant = containerSize.width
            self?.containerViewHeightConstraint.constant = containerSize.height
        }

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill

        stackView.addArrangedSubview(upperContainerView)
        stackView.addArrangedSubview(containerSizeInfoView)

        addSubview(stackView)

        stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        stackView.topAnchor.constraint(equalTo: topAnchor)
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    }

}

