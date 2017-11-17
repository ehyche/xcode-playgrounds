/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
****
# Renaming and Selecting Properties

 In all the examples up until now, the property name in the struct
 and the JSON key name in the serialized JSON were the same. However, in some cases
 you can't do that. Let's say we have the following JSON in a standard format,
 and we can't change it.

 */

let jsonData1 = """
{
   "text": "Hello, John!",
   "for": "John (john@example.com)",
   "from": "Susan (susan@example.com)"
}
""".data(using: .utf8)!

/*:
 If you took the key names verbatim, the struct would look like:

 struct Message: Codable {
     var text: String
     var for: String
     var from: String
 }

 But this won't compile because "for" is a Swift reserved word. So we will instead call
 the property "recipient" in our struct, and we simply need to provide a mapping
 between the "recipient" property name and the "for" JSON key name.

*/

import Foundation

struct Message: Codable {
    var text: String
    var recipient: String
    var from: String

    enum CodingKeys: String, CodingKey {
        case text              // Both property name and JSON key are "text"
        case recipient = "for" // Property name is "recipient" but JSON key is "for"
        case from              // Both property name and JSON key are "from"
    }
}

let result1 = CodableHelper.decode(Message.self, from: jsonData1)
CodableHelper.printDecodeResult(result: result1)

/*:
 We can also use the CodingKeys to selectively deserialize only certain fields from the JSON.

 Let's say we had a lot of other fields in the JSON:
 */

let jsonData2 = """
{
   "text": "Hello, John!",
   "for": "John (john@example.com)",
   "from": "Susan (susan@example.com)",
   "sendDate": "2015-10-02T07:00:00Z",
   "receiveDate": "2015-10-02T08:00:00Z"
}
""".data(using: .utf8)!

/*:
 But since we don't provide keys for them, thn they don't get serialized to the Message struct
 */

let result2 = CodableHelper.decode(Message.self, from: jsonData2)
CodableHelper.printDecodeResult(result: result2)

//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
