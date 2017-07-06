/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
****
# Handling enums


*/

import Foundation

enum MessageType: String, Codable {
    case unidirectional = "unidirectional"
    case bidirectional = "bidirectional"
    case oneToMany = "oneToMany"
}

struct Message: Codable {
    var text: String
    var sequenceNum: Int
    var type: MessageType
}

let json = """
{
  "text": "This is the message text",
  "sequenceNum": 4,
  "type": "bidirectional"
}
""".data(using: .utf8)!

if let message = CodableHelper.decode(Message.self, from: json) {
    print("message = \(message)")
}

let outMessage = Message(text: "Outgoing message", sequenceNum: 22, type: .bidirectional)

if let encodedMessage = CodableHelper.encode(outMessage) {
    if let encodedMessageStr = String(bytes: encodedMessage, encoding: .utf8) {
        print("encoded JSON = \n\(encodedMessageStr)\n")
    }
}




//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
