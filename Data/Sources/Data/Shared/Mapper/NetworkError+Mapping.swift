//
//  NetworkError+Mapping.swift
//  Data
//
//  Created by Mohammed Skaik on 08/07/2026.
//

import Networking
import Domain

extension NetworkError {
    func toDomainException() -> DomainException {
        switch self {
        case .unauthorized: return .unauthorized
        case .forbidden: return .forbidden
        case .notFound: return .notFound
        case .serverError(let statusCode): return .serverError(statusCode: statusCode)
        case .noInternetConnection: return .noInternet
        case .timeout: return .timeout
        case .decodingFailed: return .decodingFailed
        case .apiError(let message, _): return .apiError(message: message)
        case .unknown: return .unknown
        }
    }
}
