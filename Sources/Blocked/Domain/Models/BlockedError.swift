//
//  BlockedError.swift
//  
//
//  Created by Martin Dutra on 12/1/22.
//

import Foundation

enum BlockedError: Error, LocalizedError {

    case decodeError
    case encodeError
    case invalidIdentity
    case invalidPath(String)
    case invalidURL
    case httpStatusCode(Int)
    case other(Error)

    var errorDescription: String? {
        switch self {
        case .decodeError:
            return "Decode error"
        case .encodeError:
            return "Encode error"
        case .invalidIdentity:
            return "Invalid identity"
        case .invalidPath:
            return "Invalid path"
        case .invalidURL:
            return "Invalid URL"
        case .httpStatusCode(let statusCode):
            return "Status code: \(statusCode)"
        case .other(let error):
            return error.localizedDescription
        }
    }

    static func optional(_ error: Error?) -> BlockedError? {
        guard let error = error else { return nil }
        return BlockedError.other(error)
    }

}
