//
//  HomeViewModel.swift
//  Presentation
//
//  Created by Mohammed Skaik on 01/07/2026.
//

import SwiftUI
import Domain
import Combine

@Observable
public final class HomeViewModel {
    private let getAllSportTypeUseCase: GetAllSportTypeUseCase
    private(set) var sportTypes: [SportType] = []
    private var splitSports: (left: [SportType], right: [SportType]) {
        sportTypes.split()
    }
    var leftSports: [SportType] { splitSports.left }
    var rightSports: [SportType] { splitSports.right }
    let effect = PassthroughSubject<HomeEffect, Never>()

    public init(getAllSportTypeUseCase: GetAllSportTypeUseCase) {
        self.getAllSportTypeUseCase = getAllSportTypeUseCase
    }

}

extension HomeViewModel {

    func getSportTypes() {
        self.sportTypes = getAllSportTypeUseCase.execute()
    }

    func didSelectSport(_ sportType: SportType) {
        effect.send(.showLeagues(sportType: sportType))
    }
}
