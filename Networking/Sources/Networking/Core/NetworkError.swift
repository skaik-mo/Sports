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
    case apiError(message: String, code: Int?)
    case unknown(Error)
}

// MARK: - Equatable
extension NetworkError: Equatable {

    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.unauthorized, .unauthorized): return true
        case (.forbidden, .forbidden): return true
        case (.notFound, .notFound): return true
        case (.noInternetConnection, .noInternetConnection): return true
        case (.timeout, .timeout): return true
        case (.serverError(let l), .serverError(let r)): return l == r
        case (.decodingFailed, .decodingFailed): return true
        case (.apiError(let lm, let lc), .apiError(let rm, let rc)): return lm == rm && lc == rc
        case (.unknown, .unknown): return true
        default: return false
        }
    }
}

// MARK: - User Facing Message
extension NetworkError {

    public var errorDescription: String? {
        return switch self {
        case .unauthorized: "Session expired. Please login again."
        case .forbidden: "You don't have permission."
        case .notFound: "Resource not found."
        case .serverError(let code): "Server error (\(code)). Try again later."
        case .noInternetConnection: "No internet connection."
        case .timeout: "Request timed out."
        case .decodingFailed: "Failed to parse server response."
        case .apiError(message: let message, code: _): message
        case .unknown(let e): e.localizedDescription
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
