//
//  LeaguesViewModelNavigationDelegate.swift
//  Presentation
//
//  Created by Mohammed Skaik on 16/08/2026.
//

import Foundation

@MainActor
protocol LeaguesViewModelNavigationDelegate: AnyObject {
    func navigateToEvents(with parameters: EventsParameters)
}
