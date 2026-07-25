//
//  HomeCoordinatorView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 21/07/2026.
//

import SwiftUI
import FactoryKit

struct HomeCoordinatorView: View {
    @State private var coordinator: HomeCoordinator

    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            HomeView(
                viewModel: Container.shared.homeViewModel(),
                onNavigateToLeagues:  { sportType in
                    coordinator.push(.leagues(sportType: sportType))
                }
            )
                .navigationDestination(
                    for: HomeRoute.self
                ) { route in
                    destination(for: route)
                }
        }
//        .navigationAppearance(backgroundColor: .black, foregroundColor: .main, hideSeparator: true)
    }

    @ViewBuilder
    private func destination(for route: HomeRoute) -> some View {
        switch route {
        case .leagues(let sportType):
            LeaguesView(
                viewModel: Container.shared.leaguesViewModel(sportType),
                onNavigateToEvents: { params in
                    coordinator.push(.events(parameters: params))
                }
            )
        case .events(let parameters):
            EventsView(viewModel: Container.shared.eventsViewModel(parameters))
        }
    }
}
