//
//  AppCoordinatorView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 21/07/2026.
//

import SwiftUI

public struct AppCoordinatorView: View {
    @State private var coordinator = AppCoordinator()

    public init() { }

    public var body: some View {
        Group {
            switch coordinator.route {
            case .launch:
                LaunchView {
                    coordinator.launchDidFinish()
                }
            case .main:
                MainTabView()
            }
        }
        .task {
            coordinator.start()
        }
    }
}
