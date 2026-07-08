//
//  DataSafeCall.swift
//  Data
//
//  Created by Mohammed Skaik on 08/07/2026.
//

import Networking
import Domain

func safeCall<T>(_ action: () async throws -> T) async throws -> T {
    do {
        return try await action()
    } catch let error as NetworkError {
        throw error.toDomainException()
    } catch let error as DomainException {
        throw error
    } catch {
        throw DomainException.unknown
    }
}
