
import Foundation

//Possible errors we can encounter
enum NetworkError: Error {
    case domainError
    case decodingError
    case responseError
    case encodingError
}
