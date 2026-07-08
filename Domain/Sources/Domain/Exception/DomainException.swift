//
//  DomainException.swift
//  Domain
//
//  Created by Mohammed Skaik on 08/07/2026.
//

public enum DomainException: Error {
    case unauthorized
    case forbidden
    case notFound
    case serverError
    case noInternet
    case timeout
    case decodingFailed
    case apiError(message: String)
    case noDataFound
    case dateCalculationFailed
    case invalidDate
    case unknown
}
