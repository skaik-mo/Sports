//
//  FavoriteDataServiceTests.swift
//  SportsTests
//
//  Created by Mohammed Skaik on 28/10/2024.
//

import XCTest
import SwiftData
@testable import Sports

final class FavoriteDataServiceTests: XCTestCase {

    var dataService: FavoriteDataService!
    var modelContainer: ModelContainer!

    @MainActor
    override func setUpWithError() throws {
        print(#function)
        let schema = Schema([Favorite.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        modelContainer = try ModelContainer(for: schema, configurations: [configuration])
        dataService = FavoriteDataService()
        dataService.modelContext = modelContainer.mainContext
    }

    override func tearDownWithError() throws {
        print(#function)
        dataService = nil
        modelContainer = nil
    }

    private func createFavorite(id: Int, leagueName: String) -> Favorite {
        let league = League(league_key: id, league_name: leagueName, country_key: 1, country_name: "Eurocups", league_logo: "https://apiv2.allsportsapi.com/logo/logo_leagues/3_uefa_champions_league.png", country_logo: nil)
        return Favorite(league: league, sport: Sports.football)
    }

    func testSetFavorite_AddFavorite() {
        // Given
        let favorite = createFavorite(id: 3, leagueName: "UEFA Champions League")

        // When
        dataService.setFavorite(favorite)

        // Then
        let existingFavorite = dataService.checkIfFavoriteExists(favorite)
        XCTAssertEqual(existingFavorite?.id, favorite.id, "Added favorite should be found")

    }

    func testSetFavorite_ExistingFavorite_Delete() {
        // Given
        let favorite = createFavorite(id: 3, leagueName: "UEFA Champions League")
        dataService.addFavorite(favorite)

        // When
        dataService.setFavorite(favorite)

        // Then
        let existingFavorite = dataService.checkIfFavoriteExists(favorite)
        XCTAssertNil(existingFavorite, "Existing favorite should be deleted")
    }

    func testFetchFavorites() {
        // Given
        let favorite1 = createFavorite(id: 3, leagueName: "UEFA Champions League")
        let favorite2 = createFavorite(id: 4, leagueName: "UEFA Europa League")

        // When
        dataService.addFavorite(favorite1)
        dataService.addFavorite(favorite2)
        
        dataService.fetchFavorites()

        // Then
        XCTAssertEqual(dataService.favorites.count, 2, "Fetched favorites count should match added favorites")
    }

    func testDeleteFavorite() {
        // Given
        let favorite = createFavorite(id: 3, leagueName: "UEFA Champions League")

        dataService.addFavorite(favorite)

        let existingFavoriteBeforeDelete = dataService.checkIfFavoriteExists(favorite)
        XCTAssertEqual(existingFavoriteBeforeDelete?.id, favorite.id, "Favorite should exist before deletion")

        // When
        dataService.deleteFavorite(favorite)

        // Then
        let existingFavoriteAfterDelete = dataService.checkIfFavoriteExists(favorite)
        XCTAssertNil(existingFavoriteAfterDelete, "Favorite should be removed after deletion")
    }

    func testCheckIfFavoriteExists_ExistingFavorite() {
        // Given
        let favorite = createFavorite(id: 3, leagueName: "UEFA Champions League")

        // When
        dataService.addFavorite(favorite)
        let existingFavorite = dataService.checkIfFavoriteExists(favorite)

        // Then
        XCTAssertEqual(existingFavorite?.id, favorite.id, "Existing favorite should be found")

    }

    func testCheckIfFavoriteExists_NonExistingFavorite() {
        // Given
        let favorite = createFavorite(id: 3, leagueName: "UEFA Champions League")

        // When
        let existingFavorite = dataService.checkIfFavoriteExists(favorite)

        // Then
        XCTAssertNil(existingFavorite, "Non-existent favorite should not be found")
    }

}
