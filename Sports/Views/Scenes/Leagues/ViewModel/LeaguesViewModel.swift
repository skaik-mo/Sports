//
//  LeaguesViewModel.swift
//  Sports
//
//  Created by Mohammed Skaik on 05/10/2024.
//

import Foundation

@Observable
class LeaguesViewModel {
    let title = "Leagues"
    var sport: Sports
    var leagues: [League] = []

    init(sport: Sports) {
        self.sport = sport
    }

}
