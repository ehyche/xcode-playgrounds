/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
****
# When Things Go Wrong

Sometimes you get JSON from a network request that you don't expect.
This page shows how to handle those cases.

For example, in the struct below, soldQuantity is an Int.
*/

import Foundation

struct Deal: Codable {
    var dealId: String
    var soldQuantity: Int
}


/*:
 But what if the JSON we receive for it is actually a string?
 */
let jsonData1 = """
{
  "dealId": "derek-s-auto-detail-and-hand-wash-1-1",
  "soldQuantity": "5000"
}
""".data(using: .utf8)!

/*:
 In that case, we get a Type Mismatch error upon decoding, and we have to catch that exception.
 */
let decodeResult1 = CodableHelper.decode(Deal.self, from: jsonData1)
CodableHelper.printDecodeResult(result: decodeResult1)

/*:
 Another potential error would be if we got a null value when we were not expecting one.
 */
let jsonData2 = """
{
  "dealId": "derek-s-auto-detail-and-hand-wash-1-1",
  "soldQuantity": null
}
""".data(using: .utf8)!

/*:
 In that case, we get a Value Not Found error.
 */

let decodeResult2 = CodableHelper.decode(Deal.self, from: jsonData2)
CodableHelper.printDecodeResult(result: decodeResult2)

/*:
 What if we have a non-optional type in our struct, but we don't get a value for that property?
 For example, what if "soldQuantity" is just not there in the JSON?
 */
let jsonData3 = """
{
  "dealId": "derek-s-auto-detail-and-hand-wash-1-1"
}
""".data(using: .utf8)!

/*:
 In that case, we get a Key Not Found error.
 */

let decodeResult3 = CodableHelper.decode(Deal.self, from: jsonData3)
CodableHelper.printDecodeResult(result: decodeResult3)

/*:
 Another error would be if the Data value are corrupted. In the example below, note that "data" is just random characters, not valid Base64.
 */
struct DealWithData: Codable {
    var dealId: String
    var soldQuantity: Int
    var data: Data
}

let jsonData4 = """
{
  "dealId": "derek-s-auto-detail-and-hand-wash-1-1",
  "soldQuantity": 500,
  "data": "asdfasdfasfasdfasdfasdf"
}
""".data(using: .utf8)!

/*:
 In that case, we get a Data Corrupted error.
 */

let decodeResult4 = CodableHelper.decode(DealWithData.self, from: jsonData4)
CodableHelper.printDecodeResult(result: decodeResult4)

/*:
 Similarly, what if the Date we try to decode is invalid?
 */
struct DealWithDate: Codable {
    var dealId: String
    var soldQuantity: Int
    var date: Date
}

let jsonData5 = """
{
  "dealId": "derek-s-auto-detail-and-hand-wash-1-1",
  "soldQuantity": 500,
  "date": "2015.10.02"
}
""".data(using: .utf8)!

/*:
 In that case, we also get a Data Corrupted error.
 */

let decodeResult5 = CodableHelper.decode(DealWithDate.self, from: jsonData5)
CodableHelper.printDecodeResult(result: decodeResult5)

/*:
 And what happens if the JSON itself is invalid?
 */
let jsonData6 = """
{
  "dealId": "derek-s-auto-detail-and-hand-wash-1-1",
  "soldQuantity": home, home on the range...
}
""".data(using: .utf8)!

/*:
 In that case, we get a general error
 */

let decodeResult6 = CodableHelper.decode(Deal.self, from: jsonData6)
CodableHelper.printDecodeResult(result: decodeResult6)


//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
