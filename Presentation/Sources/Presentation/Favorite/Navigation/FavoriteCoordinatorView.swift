//
//  FavoriteCoordinatorView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 22/07/2026.
//

import SwiftUI

struct FavoriteCoordinatorView: View {
    let coordinator: FavoriteCoordinator

    var body: some View {
        RouterView(router: coordinator.router) {
            coordinator.makeFavoriteView()
        }
    }
}
