import Foundation

open class CodableHelper {

    open class func decode<T>(_ type: T.Type, from data: Data) -> T? where T : Decodable {
        var returnedDecodable: T? = nil

        let decoder = JSONDecoder()
        decoder.dataDecodingStrategy = .base64Decode
        decoder.dateDecodingStrategy = .iso8601

        do {
            returnedDecodable = try decoder.decode(type, from: data)
        } catch DecodingError.typeMismatch(let type, let context) {
            print("JSON Decoding Error: Type Mismatch (type=\(type),path=\"\(context.codingPath.textualDescription)\",description=\"\(context.debugDescription)\")")
        } catch DecodingError.valueNotFound(let type, let context) {
            print("JSON Decoding Error: Value Not Found (type=\(type),path=\"\(context.codingPath.textualDescription)\",description=\"\(context.debugDescription)\")")
        } catch DecodingError.keyNotFound(let key, let context) {
            print("JSON Decoding Error: Key Not Found (key=\(key),path=\"\(context.codingPath.textualDescription)\",description=\"\(context.debugDescription)\")")
        } catch DecodingError.dataCorrupted(let context) {
            print("JSON Decoding Error: Data Corrupted (path=\"\(context.codingPath.textualDescription)\",description=\"\(context.debugDescription)\")")
        } catch {
            print("General error: \(error)")
        }

        return returnedDecodable
    }

    open class func encode<T>(_ value: T) -> Data? where T : Encodable {
        var returnedData: Data?

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        encoder.dataEncodingStrategy = .base64Encode

        do {
            returnedData = try encoder.encode(value)
        } catch let error as EncodingError {
            print("EncodingError: \(error)")
        } catch {
            print("General error: \(error)")
        }

        return returnedData
    }

}
