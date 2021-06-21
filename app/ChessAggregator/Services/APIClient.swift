//
// Created by Administrator on 28.01.2021.
//

import Foundation

class APIClient {
    private let session = URLSession(configuration: .default)

    private var baseComponents: URLComponents

    private let jsonDecoder: JSONDecoder = {
        var result = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        result.dateDecodingStrategy = .formatted(dateFormatter)
        result.keyDecodingStrategy = .convertFromSnakeCase
        return result
    }()

    private let jsonEncoder: JSONEncoder = {
        var result = JSONEncoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        result.dateEncodingStrategy = .formatted(dateFormatter)
        result.keyEncodingStrategy = .convertToSnakeCase
        return result
    }()

    init() {
        baseComponents = URLComponents()
        baseComponents.scheme = "https" // TODO
        baseComponents.host = "8622a877ef08.ngrok.io" // TODO
        //baseComponents.queryItems = [URLQueryItem(name: "api_key", value: "key")] // TODO: key -> init
    }


















    /// https://8622a877ef08.ngrok.io

    func dataTask<T: Codable>(_ path: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = makeURL(path: path) else {
            completion(.failure(InternalError.unknownPath))
            return
        }

        let request = URLRequest(url: url)

        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            else if let data = data {
                do {
                    let result = try self.jsonDecoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                }
                catch let error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
    }

    func post<T: Codable>(path: String, user: UserResponse, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = makeURL(path: path) else {
            completion(.failure(InternalError.unknownPath))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try jsonEncoder.encode(user)
        }
        catch let error {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
            return
        }

        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else if let data = data {
                do {
                    let result = try self.jsonDecoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                }
                catch let error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }

            }
        }
        task.resume()
    }

    private func makeURL(path: String) -> URL? {
        var result = baseComponents
        result.path = "\(path)"
        return result.url
    }

    enum InternalError: Error {
        case unknownPath
        case internalServerError
    }
}

struct UserResponse : Codable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let password: String
    let birthdate: Date
//    let frcId: Int

    init(from user: User) {
        self.id = 228
        self.email = user.email
        self.firstName = user.player.firstName
        self.lastName = user.player.lastName
        self.password = "SukaBlyat"
        self.birthdate = user.player.birthdate
//        self.frcId = user.player.frcID ?? 0
    }
}
