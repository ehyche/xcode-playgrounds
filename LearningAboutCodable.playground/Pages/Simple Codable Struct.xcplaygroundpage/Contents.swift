/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
****
# Simple Codable Struct

You can make a struct JSON-decodable by simply declaring it as conforming to the Codable protocol
*/

import Foundation

/*:
 Here is a simple deal-like struct
 */
struct Deal: Codable {
    var dealId: String
    var soldQuantity: Int
}

/*:
 Here is some JSON data which might represent it.
 */
let jsonData1 = """
{
  "dealId": "derek-s-auto-detail-and-hand-wash-1-1",
  "soldQuantity": 5000
}
""".data(using: .utf8)!

/*:
 Now all we have to do is tell the JSONDecoder to decode it.
 */
let decodeResult1 = CodableHelper.decode(Deal.self, from: jsonData1)
CodableHelper.printDecodeResult(result: decodeResult1)

/*:
 Standard library types like String, Int, Bool, Float, and Double support Codable, as do Foundation types like Date, Data, and URL.
 */
struct BigDeal: Codable {
    var dealId: String
    var soldQuantity: Int
    var distance: Float
    var lat: Double
    var lng: Double
    var imageURL: URL
    var isSoldOut: Bool
    var encodedText: Data
    var startAt: Date
}

let jsonData2 = """
{
  "dealId": "derek-s-auto-detail-and-hand-wash-1-1",
  "soldQuantity": 5000,
  "distance": 2.2,
  "lat": 30.29450,
  "lng": -110.30394,
  "imageURL": "http://img.grouponcdn.com/iam/3bz6jcC4MtHcH2WKA5BR/s3-2048x1229/v1/",
  "isSoldOut": false,
  "encodedText": "VGhpcyBpcyBlbmNvZGVkIHRleHQ=",
  "startAt": "2015-10-02T07:00:00Z"
}
""".data(using: .utf8)!

/*:
 For Date and Data, we need to tell JSONDecoder how to interpret the JSON.
 */
let decodeResult2 = CodableHelper.decode(BigDeal.self, from: jsonData2)
CodableHelper.printDecodeResult(result: decodeResult2)

/*:
 You can have embedded types as well. As long as all of your types conform to Codable, then the containing object conforms to Codable.
 */
struct Currency: Codable {
    var amount: Int
    var currencyCode: String
    var formattedAmount: String
}

struct PriceSummary: Codable {
    var discountPercent: Int
    var price: Currency
}

struct BigDealWithPriceSummary: Codable {
    var dealId: String
    var soldQuantity: Int
    var distance: Float
    var lat: Double
    var lng: Double
    var imageURL: URL
    var isSoldOut: Bool
    var encodedText: Data
    var startAt: Date
    var priceSummary: PriceSummary
}

let jsonData3 = """
{
  "dealId": "derek-s-auto-detail-and-hand-wash-1-1",
  "soldQuantity": 5000,
  "distance": 2.2,
  "lat": 30.29450,
  "lng": -110.30394,
  "imageURL": "http://img.grouponcdn.com/iam/3bz6jcC4MtHcH2WKA5BR/s3-2048x1229/v1/",
  "isSoldOut": false,
  "encodedText": "VGhpcyBpcyBlbmNvZGVkIHRleHQ=",
  "startAt": "2015-10-02T07:00:00Z",
  "priceSummary": {
    "discountPercent": 53,
    "price": {
      "amount": 8900,
      "currencyCode": "USD",
      "formattedAmount": "$89.00"
    }
  }
}
""".data(using: .utf8)!

let decodeResult3 = CodableHelper.decode(BigDealWithPriceSummary.self, from: jsonData3)
switch decodeResult3 {
    case .success(let deal):
        print("Decode Success: deal = \(deal)")
    case .failure(let error):
        print("Decoding Error: error = \(String(describing: error))")
        break
}

//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
