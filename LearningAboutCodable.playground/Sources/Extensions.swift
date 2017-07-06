import Foundation

extension Array where Array.Element == CodingKey? {
    var textualDescription: String {
        let itemsAsText = self.map { $0?.stringValue ?? "(nil)" }
        return itemsAsText.joined(separator: ".")
    }
}

