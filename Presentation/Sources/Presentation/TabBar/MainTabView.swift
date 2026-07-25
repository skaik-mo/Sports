//
//  MainTabView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 22/07/2026.
//

import SwiftUI

struct MainTabView: View {
    @State private var coordinator: MainTabCoordinator

    init(coordinator: MainTabCoordinator) {
        self.coordinator = coordinator
    }

    var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            HomeCoordinatorView(coordinator: coordinator.homeCoordinator)
                .tag(TabRoute.home)

            FavoriteCoordinatorView(
                coordinator: coordinator.favoriteCoordinator
            )
            .tag(TabRoute.favorite)
        }
    }
}
