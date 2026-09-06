//
//  HomeViewModelNavigationDelegate.swift
//  Presentation
//
//  Created by Mohammed Skaik on 16/08/2026.
//

import Foundation
import Domain

@MainActor
protocol HomeViewModelNavigationDelegate: AnyObject {
    func navigateToLeagues(for sportType: SportType)
}
