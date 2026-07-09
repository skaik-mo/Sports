//
//  BaseViewModel.swift
//  Presentation
//
//  Created by Mohammed Skaik on 08/07/2026.
//

import Foundation
import Domain

@MainActor
@Observable
public class BaseViewModel<State> {
    public private(set) var state: State
    private let taskManager = TaskManager()

    public init(initialState: State) {
        self.state = initialState
    }

    public func updateState(_ updater: (State) -> State) {
        state = updater(state)
    }

    public func updateState<Value>(
        key keyPath: WritableKeyPath<State, Value>,
        to value: Value
    ) {
        state[keyPath: keyPath] = value
    }

    public func tryToExecute<T>(
        id: String,
        onFailure: @escaping (DomainException) -> Void,
        onSuccess: @escaping (T) -> Void,
        block: @escaping () async throws -> T
    ) {
        taskManager.run(id: id) { [weak self] in
            do {
                let result = try await block()
                try Task.checkCancellation()
                onSuccess(result)
            } catch is CancellationError {
                return
            } catch {
                onFailure(self?.mapToDomainException(error) ?? .unknown)
            }
        }
    }

    public func cancelAllTasks() {
        taskManager.cancelAll()
    }

    private func mapToDomainException(_ error: Error) -> DomainException {
        (error as? DomainException) ?? .unknown
    }
}
