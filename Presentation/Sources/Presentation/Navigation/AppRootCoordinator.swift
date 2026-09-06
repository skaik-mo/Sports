//
//  AppRootCoordinator.swift
//  Presentation
//
//  Created by Mohammed Skaik on 21/07/2026.
//

import Observation

@MainActor
@Observable
final class AppRootCoordinator {

    var destination: AppRootDestination = .launch

    func start() {
        destination = .launch
    }

    func launchDidFinish() {
        destination = .main
    }
}

