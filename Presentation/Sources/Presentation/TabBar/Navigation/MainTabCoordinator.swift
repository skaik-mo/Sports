//
//  MainTabCoordinator.swift
//  Presentation
//
//  Created by Mohammed Skaik on 25/07/2026.
//

import Observation

@MainActor
@Observable
final class MainTabCoordinator {
    var selectedTab: TabRoute = .home
    let homeCoordinator: HomeCoordinator
    let favoriteCoordinator: FavoriteCoordinator

    init(
        homeCoordinator: HomeCoordinator = HomeCoordinator(),
        favoriteCoordinator: FavoriteCoordinator = FavoriteCoordinator()
    ) {
        self.homeCoordinator = homeCoordinator
        self.favoriteCoordinator = favoriteCoordinator
    }
}
