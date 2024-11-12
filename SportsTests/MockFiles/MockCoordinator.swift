//
//  MockCoordinator.swift
//  Sports
//
//  Created by Mohammed Skaik on 29/10/2024.
//

import XCTest
@testable import Sports
@testable import SportTypeKit

class MockCoordinator: Coordinator {
    private(set) var popped = false
    private(set) var navigatedToRoot = false
    private(set) var navigatedToLeaguesSport: SportType?
    private(set) var navigatedToEventsSport: SportType?
    private(set) var navigatedToEventsLeague: League?

    func pop() {
        popped = true
    }

    func navigateToRoot() {
        navigatedToRoot = true
    }

    func navigateToLeagues(_ sport: SportType) {
        navigatedToLeaguesSport = sport
    }

    func navigateToEvents(_ sport: SportType, _ league: League) {
        navigatedToEventsSport = sport
        navigatedToEventsLeague = league
    }
}
