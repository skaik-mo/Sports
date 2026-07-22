//
//  Coordinator.swift
//  Presentation
//
//  Created by Mohammed Skaik on 21/07/2026.
//


@MainActor
protocol Coordinator: AnyObject {

    associatedtype Route: Hashable

    var path: [Route] { get set }
}

extension Coordinator {

    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path.removeAll()
    }
}





