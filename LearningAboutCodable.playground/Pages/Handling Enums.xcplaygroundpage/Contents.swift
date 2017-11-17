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

let result1 = CodableHelper.decode(Message.self, from: json)
CodableHelper.printDecodeResult(result: result1)

let outMessage = Message(text: "Outgoing message", sequenceNum: 22, type: .bidirectional)

let result2 = CodableHelper.encode(outMessage)
CodableHelper.printEncodeResult(result: result2)




//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
