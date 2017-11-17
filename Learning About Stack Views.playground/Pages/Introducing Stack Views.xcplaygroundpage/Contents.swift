import UIKit
import PlaygroundSupport

let liveView = EHContainerViewWithColorableStackView.containerWithDoublyCenteredVerticalStackView()

liveView.stackView.alignment = .center

let blue = LabelHelper.createLabel(text: "1", fontSize: 24.0, textColor: .white, bgColor: .blue)
let brown = LabelHelper.createLabel(text: "22", fontSize: 48.0, textColor: .white, bgColor: .brown)
let purple = LabelHelper.createLabel(text: "333", fontSize: 96.0, textColor: .white, bgColor: .purple)

liveView.stackView.addArrangedSubview(blue)
liveView.stackView.addArrangedSubview(brown)
liveView.stackView.addArrangedSubview(purple)


PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = liveView

