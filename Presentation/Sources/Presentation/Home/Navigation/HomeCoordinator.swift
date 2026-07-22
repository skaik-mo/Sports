//
//  HomeCoordinator.swift
//  Presentation
//
//  Created by Mohammed Skaik on 21/07/2026.
//

import Observation
import Domain

@MainActor
@Observable
final class HomeCoordinator: Coordinator {

    var path: [HomeRoute] = []

}
