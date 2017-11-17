import UIKit

public class LabelHelper {

    public class func createLabel(text: String, fontSize: CGFloat, textColor: UIColor, bgColor: UIColor) -> UILabel {
        let label = UILabel(frame: .zero)
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = textColor
        label.backgroundColor = bgColor
        return label
    }

}

