/*:
 # Using JSON with Custom Types
 
 When you control of both the structure of your data types in Swift
 and the structure of the JSON you use for encoding and decoding,
 use the default format generated for you by the `JSONEncoder` and `JSONDecoder` classes.
 
 However, when the data your code models follows a specification that shouldn't be changed,
 you should still write your data types according to Swift best practices and conventions.
 This sample shows how to use a type's conformance to the `Codable` protocol
 as the translation layer between the JSON representation of data
 and the corresponding representation in Swift.
 
 - [Simple Codable Struct](Simple%20Codable%20Struct)
 - [When Things Go Wrong](When%20Things%20Go%20Wrong)
 - [Renaming and Selecting Properties](Renaming%20and%20Selecting%20Properties)
 - [Handling Enums](Handling%20Enums)
 - [LICENSE](LICENSE)
 
 ****
 [Next](@next)
 */

