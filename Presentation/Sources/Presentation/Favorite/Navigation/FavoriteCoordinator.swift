//
//  FavoriteCoordinator.swift
//  Presentation
//
//  Created by Mohammed Skaik on 22/07/2026.
//

import SwiftUI
import Observation
import Domain
import FactoryKit

@MainActor
@Observable
final class FavoriteCoordinator: Coordinator {
    let router: Router

    init(router: Router = Router()) {
        self.router = router
    }

    func makeFavoriteView() -> FavoriteView {
        let viewModel = Container.shared.favoriteViewModel()
        viewModel.navigationDelegate = self
        return FavoriteView(viewModel: viewModel)
    }

    func showEvents(parameters: EventsParameters) {
        router.push(id: FavoriteDestination.events(parameters: parameters)) {
            EventsView(viewModel: Container.shared.eventsViewModel(parameters))
        }
    }
}

extension FavoriteCoordinator: FavoriteViewModelNavigationDelegate {
    func navigateToEvents(with parameters: EventsParameters) {
        showEvents(parameters: parameters)
    }
}
