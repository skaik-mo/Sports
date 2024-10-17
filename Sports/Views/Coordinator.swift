//
//  Coordinator.swift
//  Sports
//
//  Created by Mohammed Skaik on 17/10/2024.
//

import SwiftUI

// MARK: - Coordinator
@MainActor
protocol Coordinator {
    func pop()
    func navigateToRoot()
    func navigateToLeagues(_ sport: Sports)
    func navigateToEvents(_ sport: Sports, _ league: League)
}

// MARK: - Default Coordinator
final class DefaultCoordinator: RoutableCoordinator {
    enum Route: Hashable {
        case LeaguesView(Sports)
        case EventsView(Sports, League)
    }

    @Published
    var path: [Route] = []

    @Published
    var modal: ModalRoute<Route>?

    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case .LeaguesView(let sport):
            LeaguesView(viewModel: .init(coordinator: self, sport: sport))
        case .EventsView(let sport, let league):
            EventsView(viewModel: .init(coordinator: self, sport: sport, league: league))
        }
    }
}

extension DefaultCoordinator: Coordinator {
    func pop() {
        guard path.count > 0 else { return }
        path.removeLast()
    }

    func navigateToRoot() {
        path.removeAll()
    }

    func navigateToLeagues(_ sport: Sports) {
        path.append(.LeaguesView(sport))
    }

    func navigateToEvents(_ sport: Sports, _ league: League) {
        path.append(.EventsView(sport, league))
    }

}
