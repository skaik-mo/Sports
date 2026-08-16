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

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        WaterfallGrid(columns: currentLayout.columns) {
            SportShapeStack(
                sportTypes: viewModel.leftSports,
                height: currentLayout.heightImage,
                font: currentLayout.font
            ) { sportType in
                viewModel.didSelectSport(sportType)
            }
            SportShapeStack(
                sportTypes: viewModel.rightSports,
                height: currentLayout.heightImage,
                font: currentLayout.font
            ) { sportType in
                viewModel.didSelectSport(sportType)
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
