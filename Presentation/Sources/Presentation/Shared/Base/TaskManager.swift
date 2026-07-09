//
//  TaskManager.swift
//  Presentation
//
//  Created by Mohammed Skaik on 09/07/2026.
//


@MainActor
public final class TaskManager {
    private var tasks: [String: Task<Void, Never>] = [:]

    public init() {}

    public func run(
        id: String,
        priority: TaskPriority? = nil,
        operation: @escaping () async -> Void
    ) {
        tasks[id]?.cancel()
        let task = Task(priority: priority) { [weak self] in
            await operation()
            self?.remove(id)
        }
        tasks[id] = task
    }

    public func cancel(id: String) {
        tasks[id]?.cancel()
        remove(id)
    }

    public func cancelAll() {
        tasks.values.forEach { $0.cancel() }
        tasks.removeAll()
    }

    private func remove(_ id: String) {
        tasks.removeValue(forKey: id)
    }

    deinit {
        tasks.values.forEach { $0.cancel() }
    }
}
