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
