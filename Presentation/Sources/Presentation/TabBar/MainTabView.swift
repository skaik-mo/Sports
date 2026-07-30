//
//  MainTabView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 22/07/2026.
//

import SwiftUI
import DesignSystem

struct MainTabView: View {
    @State private var coordinator: MainTabCoordinator
    private var shouldShowTabBar: Bool {
        switch coordinator.selectedTab {
        case .home: return coordinator.homeCoordinator.path.isEmpty
        case .favorite: return coordinator.favoriteCoordinator.path.isEmpty
        }
    }

    init(coordinator: MainTabCoordinator) {
        self.coordinator = coordinator
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $coordinator.selectedTab) {
                HomeCoordinatorView(coordinator: coordinator.homeCoordinator)
                    .toolbar(.hidden, for: .tabBar)
                    .tag(TabRoute.home)

                FavoriteCoordinatorView(
                    coordinator: coordinator.favoriteCoordinator
                )
                .toolbar(.hidden, for: .tabBar)
                .tag(TabRoute.favorite)
            }

            if shouldShowTabBar {
                CustomTabBar(selectedTab: $coordinator.selectedTab)
                    .padding(.bottom, AppSpacing.sm)
                    .padding(.horizontal, AppSpacing.lg)
            }
        }
    }
}
