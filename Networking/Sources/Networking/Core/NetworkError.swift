//
//  NetworkError.swift
//  Networking
//
//  Created by Mohammed Skaik on 14/06/2026.
//

import Alamofire
import Foundation

public enum NetworkError: LocalizedError {

    case unauthorized
    case forbidden
    case notFound
    case serverError(statusCode: Int)
    case noInternetConnection
    case timeout
    case decodingFailed(Error)
    case unknown(Error)
}

// MARK: - User Facing Message
extension NetworkError {

    public var errorDescription: String? {
        switch self {
        case .unauthorized: return "Session expired. Please login again."
        case .forbidden: return "You don't have permission."
        case .notFound: return "Resource not found."
        case .serverError(let code): return "Server error (\(code)). Try again later."
        case .noInternetConnection: return "No internet connection."
        case .timeout: return "Request timed out."
        case .decodingFailed: return "Failed to parse server response."
        case .unknown(let e): return e.localizedDescription
        }
    }
}

// MARK: - Mapping
extension NetworkError {

    static func from(_ response: AFDataResponse<Data>, _ error: AFError) -> NetworkError {

        if let urlError = error.underlyingError as? URLError {
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost:
                return .noInternetConnection
            case .timedOut:
                return .timeout
            default:
                break
            }
        }

        if let statusCode = response.response?.statusCode {
            switch statusCode {
            case 401: return .unauthorized
            case 403: return .forbidden
            case 404: return .notFound
            case 500...: return .serverError(statusCode: statusCode)
            default: break
            }
        }

        return .unknown(error)
    }
}
