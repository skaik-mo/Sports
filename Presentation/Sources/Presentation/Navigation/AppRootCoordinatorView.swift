//
//  AppCoordinatorView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 21/07/2026.
//

import SwiftUI

public struct AppRootCoordinatorView: View {
    @State private var coordinator = AppRootCoordinator()

    public init() { }

    public var body: some View {
        Group {
            switch coordinator.route {
            case .launch:
                LaunchView {
                    coordinator.launchDidFinish()
                }
            case .main:
                MainTabView(coordinator: MainTabCoordinator())
            }
        }
        .task {
            coordinator.start()
        }
    }
}
