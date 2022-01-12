//
//  PlanetaryService.swift
//  
//
//  Created by Martin Dutra on 12/1/22.
//

import Foundation
import Logger

class PlanetaryService: APIService {

    private var scheme: String
    private var host: String
    private var port: Int
    private var path: String
    private var session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.scheme = "https"
        self.host = "us-central1-pub-verse-app.cloudfunctions.net"
        self.port = 443
        self.path = "/block-list"
        self.session = session
    }

    func retreiveBlockedList(token: String, completion: @escaping (([Identity], BlockedError?) -> Void)) {
        get(path: path, token: token) { data, error in
            if let data = data {
                do {
                    let identifiers = try JSONDecoder().decode([String].self, from: data)
                    completion(identifiers.map { Identity(identifier: $0)}, error)
                } catch {
                    completion([], .decodeError)
                }
            }
        }
    }

}

// MARK: API
extension PlanetaryService {

    func get(path: String, token: String, completion: @escaping ((Data?, BlockedError?) -> Void)) {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        components.port = self.port

        guard let url = components.url else {
            completion(nil, .invalidURL)
            return
        }

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "X-Planetary-Bearer-Token")
        request.httpMethod = "GET"

        session.dataTask(with: request) { data, response, error in
            let blockedError = response?.httpStatusCodeError ?? .optional(error)
            Logger.shared.optional(blockedError, from: response)
            DispatchQueue.main.async {
                completion(data, blockedError)
            }
        }.resume()
    }

}

fileprivate extension Dictionary {

    func data() -> Data? {
        let dictionary = self.copyByTransformingValues(of: Date.self) {
            date in
            return date.iso8601String
        }
        return try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
    }

    // This could support an array of transforms to prevent
    // looping multiple times for multiple value types.
    func copyByTransformingValues<T: Any>(of type: T.Type,
                                          using: ((T) -> String)) -> Dictionary<Key, Any>
    {
        var dictionary: [Key: Any] = [:]
        self.forEach {
            if let value = $0.value as? T   { dictionary[$0.key] = using(value) }
            else                            { dictionary[$0.key] = $0.value }
        }
        return dictionary
    }
}

fileprivate extension Date {

    private static let iso8601Formatter = ISO8601DateFormatter()

    var iso8601String: String {
        return Date.iso8601Formatter.string(from: self)
    }

}

fileprivate extension URLResponse {

    var httpStatusCodeError: BlockedError? {
        guard let response = self as? HTTPURLResponse else { return nil }
        if response.statusCode > 201 { return .httpStatusCode(response.statusCode) }
        else { return nil }
    }

}

extension Logger {

    func optional(_ error: BlockedError?, from response: URLResponse?) {
        guard let error = error else { return }
        guard let response = response else { return }
        let path = response.url?.path ?? "unknown path"
        let detail = "\(path) \(error)"
        self.unexpected(.apiError, detail)
    }

}
