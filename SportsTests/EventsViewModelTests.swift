//
//  EventsViewModelTests.swift
//  Sports
//
//  Created by Mohammed Skaik on 29/10/2024.
//

import XCTest
@testable import Sports
import SwiftData

class EventsViewModelTests: XCTestCase {

    private var mockCoordinator: MockCoordinator!
    private var mockNetworkService: MockNetworkService!
    private var modelContainer: ModelContainer!
    private var viewModel: EventsViewModel!

    @MainActor
    override func setUpWithError() throws {
        mockCoordinator = MockCoordinator()
        mockNetworkService = MockNetworkService()

        let league = League(league_key: 3, league_name: "UEFA Champions League", country_key: 1, country_name: "Eurocups", league_logo: "https://apiv2.allsportsapi.com/logo/logo_leagues/3_uefa_champions_league.png", country_logo: nil)
        viewModel = EventsViewModel(coordinator: mockCoordinator, networkService: mockNetworkService, sport: .football, league: league)

        let schema = Schema([Favorite.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        modelContainer = try ModelContainer(for: schema, configurations: [configuration])
        viewModel.dataService.modelContext = modelContainer.mainContext
    }

    override func tearDownWithError() throws {
        mockCoordinator = nil
        mockNetworkService = nil
        modelContainer = nil
        viewModel = nil
    }

    private func setupSuccessfulNetworkResponse() {
        let mockResponse: [String: Any] = [
            "success": 1,
            "result": [
                [
                    "event_key": 1491237,
                    "event_date": "2024-10-23",
                    "event_time": "21:00",
                    "event_home_team": "RB Leipzig",
                    "home_team_key": 101,
                    "event_away_team": "Liverpool",
                    "away_team_key": 84,
                    "event_final_result": "0 - 1",
                    "event_status": "Finished",
                    "country_name": "Eurocups",
                    "league_name": "UEFA Champions League - League Stage",
                    "league_key": 3,
                    "home_team_logo": "https://apiv2.allsportsapi.com/logo/101_rb-leipzig.jpg",
                    "away_team_logo": "https://apiv2.allsportsapi.com/logo/84_liverpool.jpg",
                    "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/3_uefa_champions_league.png",
                    "country_logo": nil,
                ],
                [
                    "event_key": 1491247,
                    "event_date": "2024-11-05",
                    "event_time": "21:00",
                    "event_home_team": "Real Madrid",
                    "home_team_key": 76,
                    "event_away_team": "AC Milan",
                    "away_team_key": 159,
                    "event_final_result": "-",
                    "event_status": "",
                    "country_name": "Eurocups",
                    "league_name": "UEFA Champions League - League Stage",
                    "league_key": 3,
                    "home_team_logo": "https://apiv2.allsportsapi.com/logo/76_real-madrid.jpg",
                    "away_team_logo": "https://apiv2.allsportsapi.com/logo/159_ac-milan.jpg",
                    "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/3_uefa_champions_league.png",
                    "country_logo": nil,
                ],
            ],
        ]
        mockNetworkService.response = mockResponse
        mockNetworkService.responseCode = 200
    }

    func testClear() {
        // Given
        setupSuccessfulNetworkResponse()
        viewModel.fetchEvents()

        XCTAssertFalse(viewModel.events.isEmpty)
        XCTAssertFalse(viewModel.upcomingEvents.isEmpty)
        XCTAssertFalse(viewModel.latestEvents.isEmpty)
        XCTAssertFalse(viewModel.teams.isEmpty)

        // When
        viewModel.clear()

        // Then
        XCTAssertTrue(viewModel.events.isEmpty)
        XCTAssertTrue(viewModel.upcomingEvents.isEmpty)
        XCTAssertTrue(viewModel.latestEvents.isEmpty)
        XCTAssertTrue(viewModel.teams.isEmpty)
    }

    func testFetchEventsSuccess() {
        // Given
        setupSuccessfulNetworkResponse()
        let fixedDate = "2024-10-30"._dateWithFormate(dataFormat: GlobalConstants.dateFormat) ?? Date.now

        // When
        viewModel.fetchEvents()

        // Then
        XCTAssertEqual(viewModel.events.count, 2, "Expected 2 events to be fetched")
        XCTAssertEqual(viewModel.upcomingEvents.count, 1, "Expected 1 upcoming event")
        XCTAssertEqual(viewModel.latestEvents.count, 1, "Expected 1 latest event")
        let upcomingEventsDate = (viewModel.upcomingEvents.first?.date?._dateWithFormate(dataFormat: GlobalConstants.dateFormat))!
        let latestEventsDate = (viewModel.latestEvents.first?.date?._dateWithFormate(dataFormat: GlobalConstants.dateFormat))!
        XCTAssertGreaterThan(upcomingEventsDate, fixedDate, "Expected upcoming event date to be after \(fixedDate._stringDate)")
        XCTAssertLessThanOrEqual(latestEventsDate, fixedDate, "Expected latest event date to be on or before \(fixedDate._stringDate)")
    }

    func testFetchEventsFailure() {
        // Given
        mockNetworkService.shouldFailRequest = true

        // When
        viewModel.fetchEvents()

        // Then
        XCTAssertEqual(viewModel.events.count, 0, "Expected no events on failure")
        XCTAssertTrue(viewModel.isEmptyData)
        XCTAssertEqual(viewModel.emptyDataTitle, "No \(viewModel.league.league_name ?? "") Matches Found from \(viewModel.formDate) to \(viewModel.toDate)")
    }

    func testSetFavoriteImage() {
        // Test case 1: Favorite exists
        // Given
        viewModel.setFavorite()


        // When
        viewModel.setFavoriteImage()

        // Then
        XCTAssertEqual(viewModel.favoriteImage, "star.fill", "Expected filled star image for favorite")

        // Test case 2: Favorite doesn't exist
        // Given
        viewModel.setFavorite()

        // When
        viewModel.setFavoriteImage()

        // Then
        XCTAssertEqual(viewModel.favoriteImage, "star", "Favorite image should be 'star' when favorite existence is unknown")
    }

    func testSetFavorite() {
        // Test case 1: Favorite exists
        // When
        viewModel.setFavorite()

        // Then
        XCTAssertEqual(viewModel.favoriteImage, "star.fill", "Expected filled star image for favorite")

        // Test case 2: Favorite doesn't exist
        // When
        viewModel.setFavorite()

        // Then
        XCTAssertEqual(viewModel.favoriteImage, "star", "Favorite image should be 'star' when favorite existence is unknown")

    }
}
