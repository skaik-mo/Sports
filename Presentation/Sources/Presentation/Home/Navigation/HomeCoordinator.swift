//
//  HomeCoordinator.swift
//  Presentation
//
//  Created by Mohammed Skaik on 21/07/2026.
//

import SwiftUI
import Observation
import Domain
import FactoryKit


@MainActor
@Observable
final class HomeCoordinator: Coordinator {
    let router: Router

    init(router: Router = Router()) {
        self.router = router
    }

}

extension HomeCoordinator {
    func makeHomeView() -> HomeView {
        let viewModel = Container.shared.homeViewModel()
        viewModel.navigationDelegate = self
        return HomeView(viewModel: viewModel)
    }

    func showLeagues(sportType: SportType) {
        router.push(id: HomeDestination.leagues(sportType: sportType)) {
            let viewModel = Container.shared.leaguesViewModel(sportType)
            viewModel.navigationDelegate = self
            return LeaguesView(viewModel: viewModel)
        }
    }

    func showEvents(parameters: EventsParameters) {
        router.push(id: HomeDestination.events(parameters: parameters)) {
            EventsView(viewModel: Container.shared.eventsViewModel(parameters))
        }
    }
}

extension HomeCoordinator: HomeViewModelNavigationDelegate {
    func navigateToLeagues(for sportType: SportType) {
        showLeagues(sportType: sportType)
    }
}

extension HomeCoordinator: LeaguesViewModelNavigationDelegate {
    func navigateToEvents(with parameters: EventsParameters) {
        showEvents(parameters: parameters)
    }
}
