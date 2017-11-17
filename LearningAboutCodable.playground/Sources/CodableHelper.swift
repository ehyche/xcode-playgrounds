import Foundation

open class CodableHelper {

    public enum DecodeResult<T> {
        case success(T)
        case failure(Error?)
    }

    open class func decode<T>(_ type: T.Type, from data: Data) -> DecodeResult<T> where T : Decodable {
        var result: DecodeResult<T> = DecodeResult.failure(nil)

        let decoder = JSONDecoder()
        decoder.dataDecodingStrategy = .base64
        decoder.dateDecodingStrategy = .iso8601

        do {
            let decodable:T = try decoder.decode(type, from: data)
            result = DecodeResult.success(decodable)
        } catch DecodingError.dataCorrupted(let context) {
            print("DecodingError: Data Corrupted, context = \(context)")
        } catch DecodingError.keyNotFound(let key, let context) {
            print("DecodingError: Key Not Found (key=\"\(key)\",context=\"\(context)\")")
        } catch DecodingError.typeMismatch(let type, let context) {
            print("DecodingError: Type Mismatch (type=\"\(type)\",context=\"\(context)\")")
        } catch DecodingError.valueNotFound(let type, let context) {
            print("DecodingError: Value Not Found (type=\"\(type)\",context=\"\(context)\")")
        } catch {
            print("General error: \(error)")
        }

        return result
    }

    open class func printDecodeResult<T>(result: DecodeResult<T>) where T: Decodable {
        switch result {
            case .success(let decodable):
                print("Decode Success: decodable = \(decodable)")
            case .failure(let error):
                let errorStr = (error != nil ? "\(error!)" : "none")
                print("Decode Failure: error = \"\(errorStr)\"")
        }
    }

    public enum EncodeResult {
        case success(Data)
        case failure(Error?)
    }

    open class func encode<T>(_ value: T) -> EncodeResult where T : Encodable {
        var result = EncodeResult.failure(nil)

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        encoder.dataEncodingStrategy = .base64

        do {
            let encodedData = try encoder.encode(value)
            result = EncodeResult.success(encodedData)
        } catch let error as EncodingError {
            print("EncodingError: \(error)")
            result = EncodeResult.failure(error)
        } catch {
            print("General error: \(error)")
            result = EncodeResult.failure(error)
        }

        return result
    }

    open class func printEncodeResult(result: EncodeResult) {
        switch result {
            case .success(let data):
                print("Encode Success: data.count = \(data.count)")
            case .failure(let error):
                let errorStr = (error != nil ? "\(error!)" : "none")
                print("Encode Failure: error = \"\(errorStr)\"")
        }
    }

}
