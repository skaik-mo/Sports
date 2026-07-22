//
//  HomeCoordinatorView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 21/07/2026.
//

import SwiftUI
import FactoryKit

struct HomeCoordinatorView: View {

    @State private var coordinator = HomeCoordinator()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            HomeView(
                viewModel: Container.shared.homeViewModel(),
                onNavigate: coordinator.push
            )
                .navigationDestination(
                    for: HomeRoute.self
                ) { route in
                    destination(for: route)
                }
        }
    }

    @ViewBuilder
    private func destination(for route: HomeRoute) -> some View {
        switch route {
        case .leagues(let sportType):
            LeaguesView(viewModel: Container.shared.leaguesViewModel(sportType))
        case .events(let parameters):
            EventsView(viewModel: Container.shared.eventsViewModel(parameters))
        }
    }
}
