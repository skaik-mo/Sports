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

    var getTeamsUseCase: Factory<GetTeamsUseCase> {
        self {
            GetTeamsUseCase(repository: self.teamRepository())
        }
    }

    var getPlayersUseCase: Factory<GetPlayersUseCase> {
        self {
            GetPlayersUseCase(repository: self.playerRepository())
        }
    }

    var getAllSportTypeUseCase: Factory<GetAllSportTypeUseCase> {
        self {
            GetAllSportTypeUseCase()
        }
    }

    var getFavoritesUseCase: Factory<GetFavoritesUseCase> {
        self {
            GetFavoritesUseCase(
                favoriteRepository: self.favoriteRepository(),
                leagueRepository: self.leagueRepository()
            )
        }
    }

    var isFavoriteUseCase: Factory<IsFavoriteUseCase> {
        self {
            IsFavoriteUseCase(repository: self.favoriteRepository())
        }
    }

    var removeFavoriteUseCase: Factory<RemoveFavoriteUseCase> {
        self {
            RemoveFavoriteUseCase(repository: self.favoriteRepository())
        }
    }

    var toggleFavoriteUseCase: Factory<ToggleFavoriteUseCase> {
        self {
            ToggleFavoriteUseCase(repository: self.favoriteRepository())
        }
    }

}

