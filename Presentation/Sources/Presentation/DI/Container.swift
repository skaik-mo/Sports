//
//  ContainerPresentation.swift
//  Presentation
//
//  Created by Mohammed Skaik on 21/07/2026.
//

import FactoryKit
import Domain

public extension Container {
    var homeViewModel: Factory<HomeViewModel> {
        Factory(self) {
            fatalError(
                "homeViewModel not registered — App must register this at launch"
            )
        }
    }

    var leaguesViewModel: ParameterFactory<SportType, LeaguesViewModel> {
        self { _ in
            fatalError(
                "leaguesViewModel must be registered in App"
            )
        }
    }

    var eventsViewModel: ParameterFactory<EventsParameters, EventsViewModel> {
        self { _ in
            fatalError(
                "eventsViewModel not registered — App must register this at launch"
            )
        }
    }

    var favoriteViewModel: Factory<FavoriteViewModel> {
        Factory(self) {
            fatalError(
                "favoriteViewModel not registered — App must register this at launch"
            )
        }
    }
}
