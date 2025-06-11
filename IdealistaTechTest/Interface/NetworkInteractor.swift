import Foundation

enum NetworkError: LocalizedError {
    case notHTTPResponse
    case statusCode(Int)
    case decodingError(Error)
    case unknownError(Error)

    var errorDescription: String? {
        switch self {
        case .notHTTPResponse:
            return "The response is not an HTTP response."
        case .statusCode(let code):
            return "Received an unexpected status code: \(code)."
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .unknownError(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}

protocol NetworkInteractor {
    var session: URLSession { get }
}

extension NetworkInteractor {
    func getData<T>(from url: URL, expecting type: T.Type) async throws -> T
    where T: Codable {

        do {
            let (data, response) = try await session.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.notHTTPResponse
            }

            guard httpResponse.statusCode == 200 else {
                throw NetworkError.statusCode(httpResponse.statusCode)
            }

            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                return result
            } catch {
                throw NetworkError.decodingError(error)
            }
        } catch let error as NetworkError {
            throw error

        } catch {
            throw NetworkError.unknownError(error)
        }
    }
}
