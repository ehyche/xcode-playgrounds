import UIKit

public typealias EHSizeDidChangeBlock = (CGSize) -> Void

public class EHContainerSizeInfoView: UIView {

    // MARK: - Public properties

    public var sizeDidChange: EHSizeDidChangeBlock?

    public private(set) var containerSize: CGSize = CGSize.zero {
        didSet {
            if containerSize != oldValue {
                sizeDidChange?(containerSize)
            }
        }
    }

    public var minContainerSize: CGSize = .zero {
        didSet {
            if minContainerSize != oldValue {
                minMaxDidChange()
            }
        }
    }

    public var maxContainerSize: CGSize = .zero {
        didSet {
            if maxContainerSize != oldValue {
                minMaxDidChange()
            }
        }
    }

    // MARK: - Private properties

    private let widthSlider = UISlider(frame: .zero)
    private let heightSlider = UISlider(frame: .zero)
    private let widthNameLabel = UILabel(frame: .zero)
    private let heightNameLabel = UILabel(frame: .zero)
    private let widthValueLabel = UILabel(frame: .zero)
    private let heightValueLabel = UILabel(frame: .zero)
    private let widthRowStackView = UIStackView(frame: .zero)
    private let heightRowStackView = UIStackView(frame: .zero)
    private let verticalStackView = UIStackView(frame: .zero)

    // MARK: - Initializers

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupView() {
        widthRowStackView.axis = .horizontal
        widthRowStackView.alignment = .center
        widthRowStackView.spacing = 10.0
        widthRowStackView.distribution = .fill
        widthRowStackView.translatesAutoresizingMaskIntoConstraints = false

        widthSlider.translatesAutoresizingMaskIntoConstraints = false
        widthSlider.isContinuous = true
        widthSlider.maximumValue = 1.0
        widthSlider.minimumValue = 0.0
        widthSlider.value = 1.0
        widthSlider.addTarget(self, action: #selector(EHContainerSizeInfoView.sliderValueDidChange), for: [.valueChanged])
        widthRowStackView.addArrangedSubview(widthSlider)

        widthNameLabel.font = UIFont(name: "OpenSans-Regular", size: 12.0)
        widthNameLabel.textColor = .black
        widthNameLabel.translatesAutoresizingMaskIntoConstraints = false
        widthNameLabel.numberOfLines = 1
        widthNameLabel.text = "Width"
        widthRowStackView.addArrangedSubview(widthNameLabel)

        widthValueLabel.font = widthNameLabel.font
        widthValueLabel.textColor = .black
        widthValueLabel.translatesAutoresizingMaskIntoConstraints = false
        widthValueLabel.numberOfLines = 1
        widthRowStackView.addArrangedSubview(widthValueLabel)

        heightRowStackView.axis = .horizontal
        heightRowStackView.alignment = .center
        heightRowStackView.spacing = 10.0
        heightRowStackView.distribution = .fill
        heightRowStackView.translatesAutoresizingMaskIntoConstraints = false

        heightSlider.translatesAutoresizingMaskIntoConstraints = false
        heightSlider.isContinuous = true
        heightSlider.maximumValue = 1.0
        heightSlider.minimumValue = 0.0
        heightSlider.value = 1.0
        heightSlider.addTarget(self, action: #selector(EHContainerSizeInfoView.sliderValueDidChange), for: [.valueChanged])
        heightRowStackView.addArrangedSubview(heightSlider)

        heightNameLabel.font = UIFont(name: "OpenSans-Regular", size: 12.0)
        heightNameLabel.textColor = .black
        heightNameLabel.translatesAutoresizingMaskIntoConstraints = false
        heightNameLabel.numberOfLines = 1
        heightNameLabel.text = "Height"
        heightRowStackView.addArrangedSubview(heightNameLabel)

        heightValueLabel.font = heightNameLabel.font
        heightValueLabel.textColor = .black
        heightValueLabel.translatesAutoresizingMaskIntoConstraints = false
        heightValueLabel.numberOfLines = 1
        heightRowStackView.addArrangedSubview(heightValueLabel)

        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.spacing = 10.0
        verticalStackView.distribution = .fill
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false

        verticalStackView.addArrangedSubview(widthRowStackView)
        verticalStackView.addArrangedSubview(heightRowStackView)

        addSubview(verticalStackView)

        leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: verticalStackView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: verticalStackView.bottomAnchor).isActive = true
    }

    private func minMaxDidChange() {
        // The slider has a value in the range [0,1]. When the min/max changes,
        // we keep the slider the same and just adjust the current size of the container
        // based upon the new values.
        let newWidth = computeDimension(minValue: minContainerSize.width, maxValue: maxContainerSize.width, sliderValue: CGFloat(widthSlider.value))
        widthValueLabel.text = "\(Int(newWidth))"
        let newHeight = computeDimension(minValue: minContainerSize.height, maxValue: maxContainerSize.height, sliderValue: CGFloat(heightSlider.value))
        heightValueLabel.text = "\(Int(newHeight))"
        containerSize = CGSize(width: newWidth, height: newHeight)
    }

    @objc private func sliderValueDidChange(slider: UISlider?) {
        if slider == widthSlider {
            let newWidth = computeDimension(minValue: minContainerSize.width, maxValue: maxContainerSize.width, sliderValue: CGFloat(widthSlider.value))
            widthValueLabel.text = "\(Int(newWidth))"
            containerSize = CGSize(width: newWidth, height: containerSize.height)
        } else if slider == heightSlider {
            let newHeight = computeDimension(minValue: minContainerSize.height, maxValue: maxContainerSize.height, sliderValue: CGFloat(heightSlider.value))
            heightValueLabel.text = "\(Int(newHeight))"
            containerSize = CGSize(width: containerSize.width, height: newHeight)
        }
    }

    private func computeDimension(minValue: CGFloat, maxValue: CGFloat, sliderValue: CGFloat) -> CGFloat {
        let maxToUse = (maxValue >= minValue ? maxValue : minValue)
        let dimension = (maxToUse - minValue) * sliderValue + minValue
        return dimension
    }

}

