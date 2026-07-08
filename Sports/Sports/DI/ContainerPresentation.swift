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
                LeaguesViewModel(sportType: .football, getAllLeaguesUseCase: self.getAllLeaguesUseCase())
            }
        }
    }
}
