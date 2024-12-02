//
//  HomeViewModelTests.swift
//  Sports
//
//  Created by Mohammed Skaik on 30/10/2024.
//

import XCTest
@testable import Sports

@MainActor
class HomeViewModelTests: XCTestCase {

    private var mockCoordinator: MockCoordinator!
    private var viewModel: HomeViewModel!

    override func setUpWithError() throws {
        mockCoordinator = MockCoordinator()
        viewModel = HomeViewModel(coordinator: mockCoordinator)
    }

    override func tearDownWithError() throws {
        mockCoordinator = nil
        viewModel = nil
    }

    func testInitialLayout() {
        // Given: ViewModel is initialized with default values

        // Then
        XCTAssertEqual(viewModel.columns.count, 2, "Expected 2 columns for initial layout")
        XCTAssertNil(viewModel.heightImage, "Expected no height image for initial layout")
        XCTAssertEqual(viewModel.fontSize, 20, "Expected font size of 20 for initial layout")

    }

    func testWaterfallLayout() {
        // Given
        viewModel.isWaterfall = true

        // Then
        XCTAssertEqual(viewModel.columns.count, 2, "Expected 2 columns for waterfall layout")
        XCTAssertNil(viewModel.heightImage, "Expected no height image for waterfall layout")
        XCTAssertEqual(viewModel.fontSize, 20, "Expected font size of 20 for waterfall layout")
    }

    func testListLayout() {
        // Given
        viewModel.isWaterfall = false

        // Then
        XCTAssertEqual(viewModel.columns.count, 1, "Expected 1 column for list layout")
        XCTAssertEqual(viewModel.heightImage, 150, "Expected height image of 150 for list layout")
        XCTAssertEqual(viewModel.fontSize, 30, "Expected font size of 30 for list layout")
    }

    func testNavigateToLeagues() {
        // Given
        let sport = Sports.football

        // When
        viewModel.navigateToLeagues(sport)

        // Then
        XCTAssertEqual(mockCoordinator.navigatedToLeaguesSport, sport, "Expected navigation to leagues for the specified sport")
    }
}
