//
//  Coordinator.swift
//  Sports
//
//  Created by Mohammed Skaik on 17/10/2024.
//

import SwiftUI
import SportTypeKit

// MARK: - Coordinator
@MainActor
protocol Coordinator {
    func pop()
    func navigateToRoot()
    func navigateToLeagues(_ sport: SportType)
    func navigateToEvents(_ sport: SportType, _ league: League)
}

// MARK: - Default Coordinator
final class DefaultCoordinator: RoutableCoordinator {
    enum Route: Hashable {
        case LeaguesView(SportType)
        case EventsView(SportType, League)
    }

    private let requestBuilder = RequestBuilder()

    @Published
    var path: [Route] = []

    @Published
    var modal: ModalRoute<Route>?

    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case .LeaguesView(let sport):
            LeaguesView(viewModel: .init(coordinator: self, networkService: requestBuilder, sport: sport))
        case .EventsView(let sport, let league):
            EventsView(viewModel: .init(coordinator: self, networkService: requestBuilder, sport: sport, league: league))
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

    func navigateToLeagues(_ sport: SportType) {
        path.append(.LeaguesView(sport))
    }

    func navigateToEvents(_ sport: SportType, _ league: League) {
        path.append(.EventsView(sport, league))
    }

}
