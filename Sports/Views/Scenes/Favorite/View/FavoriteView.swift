//
//  FavoriteView.swift
//  Sports
//
//  Created by Mohammed Skaik on 28/09/2024.
//

import SwiftUI

struct FavoriteView: View {
    @State var viewModel: FavoriteViewModel

    init(viewModel: FavoriteViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        CustomNavView(coordinator: viewModel.coordinator) {
            Text("Hello, Favorite")
        }
    }
}

#Preview {
    FavoriteView(viewModel: .init(coordinator: DefaultCoordinator()))
}
