//
//  ContainerPresentation.swift
//  Sports
//
//  Created by Mohammed Skaik on 25/06/2026.
//

import FactoryKit
import Presentation

extension Container {

    var homeViewModel: Factory<HomeViewModel> {
        self {
            HomeViewModel(getAllSportTypeUseCase: self.getAllSportTypeUseCase())
        }
    }

    var leaguesViewModel: Factory<LeaguesViewModel> {
        self {
            MainActor.assumeIsolated {
                LeaguesViewModel(
                    sportType: .football, // Change it so that it is passed from another interface.
                    getAllLeaguesUseCase: self.getAllLeaguesUseCase()
                )
            }
        }
    }

    var eventsViewModel: Factory<EventsViewModel> {
        self {
            MainActor.assumeIsolated {
                EventsViewModel(
                    getUpcomingEventsUseCase: self.getUpcomingEventsUseCase(),
                    getLatestEventsUseCase: self.getLatestEventsUseCase(),
                    getTeamsUseCase: self.getTeamsUseCase(),
                    sportType: .football, // Change it so that it is passed from another interface.
                    leagueId: 1 // Change it so that it is passed from another interface.
                )
            }
        }
    }
}
