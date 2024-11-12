//
//  FavoriteViewModelTests.swift
//  SportsTests
//
//  Created by Mohammed Skaik on 30/10/2024.
//

import XCTest
@testable import Sports
import SwiftData

@MainActor
final class FavoriteViewModelTests: XCTestCase {

    private var mockCoordinator: MockCoordinator!
    private var modelContainer: ModelContainer!
    private var viewModel: FavoriteViewModel!

    override func setUpWithError() throws {
        mockCoordinator = MockCoordinator()
        viewModel = FavoriteViewModel(coordinator: mockCoordinator)

        let schema = Schema([Favorite.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        modelContainer = try ModelContainer(for: schema, configurations: [configuration])
        viewModel.dataService.modelContext = modelContainer.mainContext
    }

    override func tearDownWithError() throws {
        mockCoordinator = nil
        modelContainer = nil
        viewModel = nil
    }

    private func createFavorite(id: Int, leagueName: String) -> Favorite {
        let league = League(league_key: id, league_name: leagueName, country_key: 1, country_name: "Eurocups", league_logo: "https://apiv2.allsportsapi.com/logo/logo_leagues/3_uefa_champions_league.png", country_logo: nil)
        return Favorite(league: league, sport: .football)
    }

    func testFetchFavorites() {
        // Given
        let mockFavorite1 = createFavorite(id: 3, leagueName: "UEFA Champions League")
        let mockFavorite2 = createFavorite(id: 4, leagueName: "UEFA Europa League")

        viewModel.dataService.addFavorite(mockFavorite1)
        viewModel.dataService.addFavorite(mockFavorite2)

        XCTAssertEqual(viewModel.dataService.favorites.count, 2)

        // When
        viewModel.fetchFavorites()

        // Then
        XCTAssertEqual(viewModel.favoritesFilter.count, 2, "Fetched favorites count should match added favorites")
    }

    func testNavigateToEvents() {
        // Given
        let mockFavorite = createFavorite(id: 3, leagueName: "UEFA Champions League")

        // When
        viewModel.navigateToEvents(mockFavorite)

        // Then
        XCTAssertEqual(mockCoordinator.navigatedToEventsSport, .football, "Expected correct sport")
        XCTAssertEqual(mockCoordinator.navigatedToEventsLeague, mockFavorite.league, "Expected correct league")
    }

    func testFindFavorites() {
        // Given
        let mockFavorite1 = createFavorite(id: 3, leagueName: "UEFA Champions League")
        let mockFavorite2 = createFavorite(id: 4, leagueName: "UEFA Europa League")

        viewModel.dataService.addFavorite(mockFavorite1)
        viewModel.dataService.addFavorite(mockFavorite2)
        viewModel.fetchFavorites()

        // When
        viewModel.searchText = "Europa"

        // Then
        XCTAssertEqual(viewModel.favoritesFilter.count, 1, "Expected 1 favorites after filtering")
        XCTAssertEqual(viewModel.favoritesFilter.first?.league.league_name, "UEFA Europa League", "Expected first league to be UEFA Europa League")

        // When
        viewModel.searchText = ""

        // Then
        XCTAssertEqual(viewModel.favoritesFilter.count, 2, "Expected all leagues after clearing search")
    }

    func testDeleteFavorite() {
        // Given
        let mockFavorite = createFavorite(id: 3, leagueName: "UEFA Champions League")
        viewModel.dataService.addFavorite(mockFavorite)
        viewModel.fetchFavorites()

        // When
        viewModel.deleteFavorite(mockFavorite)

        // Then
        XCTAssertEqual(viewModel.favoritesFilter.count, 0, "Expected no favorites after deletion")
    }

}
