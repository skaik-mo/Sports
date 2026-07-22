//
//  HomeView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 01/07/2026.
//

import SwiftUI
import DesignSystem

struct HomeView: View {
    @State private var viewModel: HomeViewModel
    @State private var currentLayout: HomeLayoutStyle = .waterfall
    private let onNavigate: (HomeRoute) -> Void

    init(
        viewModel: HomeViewModel,
        onNavigate: @escaping (HomeRoute) -> Void
    ) {
        self._viewModel = State(initialValue: viewModel)
        self.onNavigate = onNavigate
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
                sportTypes:viewModel.rightSports,
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
        .onReceive(viewModel.effect) { effect in
            switch effect {
            case .showLeagues(let sportType):
                onNavigate(.leagues(sportType: sportType))
            }
        }
    }

}
