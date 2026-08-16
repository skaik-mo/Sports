//
//  HomeCoordinatorView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 21/07/2026.
//

import SwiftUI
import FactoryKit

struct HomeCoordinatorView: View {
    let coordinator: HomeCoordinator

    var body: some View {
        RouterView(router: coordinator.router) {
            coordinator.makeHomeView()
        }
    }
}
