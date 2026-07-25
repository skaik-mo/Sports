//
//  AppCoordinator.swift
//  Presentation
//
//  Created by Mohammed Skaik on 21/07/2026.
//

import Observation

@MainActor
@Observable
final class AppRootCoordinator {

    var route: AppRoute = .launch

    func start() {
        route = .launch
    }

    func launchDidFinish() {
        route = .main
    }
}
