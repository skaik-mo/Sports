//
//  LaunchViewModelTests.swift
//  Sports
//
//  Created by Mohammed Skaik on 30/10/2024.
//

import XCTest
@testable import Sports

class LaunchViewModelTests: XCTestCase {

    var viewModel: LaunchViewModel!

    override func setUpWithError() throws {
        viewModel = LaunchViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testInitialValues() {
        // Given: ViewModel is initialized

        // Then
        XCTAssertTrue(viewModel.isAnimating, "Initial animation state should be true")
        XCTAssertFalse(viewModel.isShowing, "Initial visibility state should be false")

    }

}
