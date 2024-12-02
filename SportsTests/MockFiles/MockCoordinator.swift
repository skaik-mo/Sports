//
//  MockCoordinator.swift
//  Sports
//
//  Created by Mohammed Skaik on 29/10/2024.
//

import XCTest
@testable import Sports

class MockCoordinator: Coordinator {
    private(set) var popped = false
    private(set) var navigatedToRoot = false
    private(set) var navigatedToLeaguesSport: Sports?
    private(set) var navigatedToEventsSport: Sports?
    private(set) var navigatedToEventsLeague: League?

    func pop() {
        popped = true
    }

    func navigateToRoot() {
        navigatedToRoot = true
    }

    func navigateToLeagues(_ sport: Sports) {
        navigatedToLeaguesSport = sport
    }

    func navigateToEvents(_ sport: Sports, _ league: League) {
        navigatedToEventsSport = sport
        navigatedToEventsLeague = league
    }
}
