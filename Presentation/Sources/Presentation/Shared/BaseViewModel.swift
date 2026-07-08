//
//  BaseViewModel.swift
//  Presentation
//
//  Created by Mohammed Skaik on 08/07/2026.
//

import Foundation
import Domain

@Observable
public class BaseViewModel<T> {

    // MARK: - State
    private(set) var state: ViewState<T> = .loading

    // MARK: - Init
    public init() {}
}

// MARK: - Safe Calls
extension BaseViewModel {

    @MainActor
    func safeCall(action: () async throws -> T) async {
        state = .loading
        do {
            let result = try await action()
            state = isEmpty(result) ? .empty : .success(result)
        } catch {
            state = .failure(mapError(error))
        }
    }

    //    @MainActor
    //    func safeCallSync(action: () throws -> T) {
    //        state = .loading
    //        do {
    //            let result = try action()
    //            state = isEmpty(result) ? .empty : .success(result)
    //        } catch {
    //            state = .failure(mapError(error))
    //        }
    //    }
}

private extension BaseViewModel {
    func isEmpty(_ result: T) -> Bool {
        if let collection = result as? any Collection {
            return collection.isEmpty
        }
        return false
    }

    func mapError(_ error: Error) -> String {
        if let appError = error as? DomainException {
            return appError.userMessage
        }
        return L10n.Error.unknown
    }
}
