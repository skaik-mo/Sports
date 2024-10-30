//
//  LeaguesViewModelTests.swift
//  SportsTests
//
//  Created by Mohammed Skaik on 29/10/2024.
//

import XCTest
@testable import Sports

@MainActor
final class LeaguesViewModelTests: XCTestCase {

    private var mockCoordinator: MockCoordinator!
    private var mockNetworkService: MockNetworkService!
    private var viewModel: LeaguesViewModel!

    override func setUpWithError() throws {
        mockCoordinator = MockCoordinator()
        mockNetworkService = MockNetworkService()
        viewModel = LeaguesViewModel(coordinator: mockCoordinator, networkService: mockNetworkService, sport: .football)
    }

    override func tearDownWithError() throws {
        mockCoordinator = nil
        mockNetworkService = nil
        viewModel = nil
    }

    private func setupSuccessfulNetworkResponse() {
        let mockResponse: [String: Any] = [
            "success": 1,
            "result": [
                [
                    "league_key": 4,
                    "league_name": "UEFA Europa League",
                    "country_key": 1,
                    "country_name": "Eurocups",
                    "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/",
                    "country_logo": nil
                ],
                [
                    "league_key": 3,
                    "league_name": "UEFA Champions League",
                    "country_key": 1,
                    "country_name": "Eurocups",
                    "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/3_uefa_champions_league.png",
                    "country_logo": nil
                ],
            ],
        ]
        mockNetworkService.response = mockResponse
        mockNetworkService.responseCode = 200
    }

    func testFetchLeaguesSuccess() {
        setupSuccessfulNetworkResponse()

        // When
        viewModel.fetchLeagues()

        // Then
        XCTAssertEqual(viewModel.leagues.count, 2, "Expected 2 leagues to be fetched")
        XCTAssertEqual(viewModel.title, "Football Leagues", "Expected correct title")
    }

    func testFetchLeaguesFailure() {
        // Given
        mockNetworkService.shouldFailRequest = true

        // When
        viewModel.fetchLeagues()

        // Then
        XCTAssertEqual(viewModel.leagues.count, 0, "Expected no leagues to be fetched on failure")
        XCTAssertEqual(viewModel.emptyDataTitle, "No Football Leagues Available", "Expected empty data title on failure")
    }

    func testFindLeagues() {
        // Given
        setupSuccessfulNetworkResponse()
        viewModel.fetchLeagues()

        // When
        viewModel.searchText = "Europa"

        // Then
        XCTAssertEqual(viewModel.leagues.count, 1, "Expected 1 leagues after filtering")
        XCTAssertEqual(viewModel.leagues.first?.league_name, "UEFA Europa League", "Expected first league to be UEFA Europa League")

        // When
        viewModel.searchText = ""

        // Then
        XCTAssertEqual(viewModel.leagues.count, 2, "Expected all leagues after clearing search")
    }

    func testNavigateToEvents() {
        // Given
        let mockLeague = League(league_key: 3, league_name: "UEFA Champions League", country_key: 1, country_name: "Eurocups", league_logo: "https://apiv2.allsportsapi.com/logo/logo_leagues/3_uefa_champions_league.png", country_logo: nil)

        // When
        viewModel.navigateToEvents(mockLeague)

        // Then
        XCTAssertEqual(mockCoordinator.navigatedToEventsSport, .football, "Expected correct sport")
        XCTAssertEqual(mockCoordinator.navigatedToEventsLeague, mockLeague, "Expected correct league")
    }

}


