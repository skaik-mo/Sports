//
//  ContainerPresentation.swift
//  Sports
//
//  Created by Mohammed Skaik on 25/06/2026.
//

import FactoryKit
import Presentation

extension Container {

    func registerViewModelDependency() {
        registerHomeViewModel()
        registerLeaguesViewModel()
        registerEventsViewModel()
        registerFavoriteViewModel()
    }

    private func registerHomeViewModel() {
        self.homeViewModel.register {
            HomeViewModel(
                getAllSportTypeUseCase: self.getAllSportTypeUseCase()
            )
        }
    }

    private func registerLeaguesViewModel() {
        leaguesViewModel.register { sportType in
            MainActor.assumeIsolated {
                LeaguesViewModel(
                    sportType: sportType,
                    getAllLeaguesUseCase: self.getAllLeaguesUseCase()
                )
            }
        }
    }

    private func registerEventsViewModel() {
        eventsViewModel.register { parameters in
            MainActor.assumeIsolated {
                EventsViewModel(
                    toggleFavoriteUseCase: self.toggleFavoriteUseCase(),
                    isFavoriteUseCase: self.isFavoriteUseCase(),
                    getUpcomingEventsUseCase: self.getUpcomingEventsUseCase(),
                    getLatestEventsUseCase: self.getLatestEventsUseCase(),
                    getTeamsUseCase: self.getTeamsUseCase(),
                    getPlayersUseCase: self.getPlayersUseCase(),
                    sportType: parameters.sportType,
                    leagueId: parameters.leagueId

                )
            }
        }
    }

    private func registerFavoriteViewModel() {
        self.favoriteViewModel.register {
            MainActor.assumeIsolated {
                FavoriteViewModel(
                    getFavoritesUseCase: self.getFavoritesUseCase(),
                    removeFavoriteUseCase: self.removeFavoriteUseCase()
                )
            }
        }
    }
}
