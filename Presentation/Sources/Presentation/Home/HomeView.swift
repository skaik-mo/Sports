//
//  HomeView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 01/07/2026.
//

import SwiftUI
import DesignSystem
import Domain

struct HomeView: View {
    @State private var viewModel: HomeViewModel
    @State private var currentLayout: HomeLayoutStyle = .waterfall
    private let onNavigateToLeagues: (SportType) -> Void

    init(
        viewModel: HomeViewModel,
        onNavigateToLeagues: @escaping (SportType) -> Void
    ) {
        self.viewModel = viewModel
        self.onNavigateToLeagues = onNavigateToLeagues
    }

    var body: some View {
        WaterfallGrid(columns: currentLayout.columns) {
            SportShapeStack(
                sportTypes: viewModel.leftSports,
                height: currentLayout.heightImage,
                font: currentLayout.font
            ) { sportType in
                onNavigateToLeagues(sportType)
            }
            SportShapeStack(
                sportTypes:viewModel.rightSports,
                height: currentLayout.heightImage,
                font: currentLayout.font
            ) { sportType in
                onNavigateToLeagues(sportType)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: currentLayout)
        .navigationTitle(L10n.Home.title)
        .background(AppColors.background)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                LayoutSegmentedControl(selection: $currentLayout)
            }
            .hideSharedBackgroundIfAvailable()
        }
        .onAppear {
            viewModel.getSportTypes()
        }
    }

}
