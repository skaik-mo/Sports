//
//  DomainException+UI.swift
//  Presentation
//
//  Created by Mohammed Skaik on 08/07/2026.
//

import Domain

extension DomainException {
    var userMessage: String {
        switch self {
        // MARK: - Network
        case .unauthorized: return L10n.Error.unauthorized
        case .forbidden: return L10n.Error.forbidden
        case .notFound: return L10n.Error.notFound
        case .serverError: return L10n.Error.serverError
        case .noInternet: return L10n.Error.noInternet
        case .timeout: return L10n.Error.timeout
        case .decodingFailed: return L10n.Error.decodingFailed
        case .apiError(let message): return message

        // MARK: - Data
        case .noDataFound: return L10n.Error.noDataFound
        case .dateCalculationFailed: return L10n.Error.dateCalculation
        case .invalidDate: return L10n.Error.invalidDate

        // MARK: - General
        case .unknown: return L10n.Error.unknown
        }
    }
}
