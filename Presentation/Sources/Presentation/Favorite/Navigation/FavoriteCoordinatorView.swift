//
//  FavoriteCoordinatorView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 22/07/2026.
//

import SwiftUI
import FactoryKit

struct FavoriteCoordinatorView: View {
    @State private var coordinator: FavoriteCoordinator

    init(coordinator: FavoriteCoordinator) {
        self.coordinator = coordinator
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            FavoriteView(
                viewModel: Container.shared.favoriteViewModel(),
                onNavigateToEvents: { params in
                    coordinator.push(.events(parameters: params))
                }
            )
            .navigationDestination(
                for: FavoriteRoute.self
            ) { route in
                destination(for: route)
            }
        }
//        .navigationAppearance(backgroundColor: .black, foregroundColor: .main, hideSeparator: true)
    }

    @ViewBuilder
    private func destination(for route: FavoriteRoute) -> some View {
        switch route {
        case .events(let parameters):
            EventsView(viewModel: Container.shared.eventsViewModel(parameters))
        }
    }
}
