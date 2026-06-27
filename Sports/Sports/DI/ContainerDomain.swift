//
//  ContainerDomain.swift
//  Sports
//
//  Created by Mohammed Skaik on 25/06/2026.
//

import FactoryKit
import Domain

extension Container {
    var getAllLeaguesUseCase: Factory<GetAllLeaguesUseCase> {
        self {
            GetAllLeaguesUseCase(repository: self.leagueRepository())
        }
    }

    var getLatestEventsUseCase: Factory<GetLatestEventsUseCase> {
        self {
            GetLatestEventsUseCase(repository: self.eventRepository())
        }
    }

    var getUpcomingEventsUseCase: Factory<GetUpcomingEventsUseCase> {
        self {
            GetUpcomingEventsUseCase(repository: self.eventRepository())
        }
    }
}
