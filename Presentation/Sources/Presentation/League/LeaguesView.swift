//
//  LeaguesView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 08/07/2026.
//

import SwiftUI
import DesignSystem

struct LeaguesView: View {
    @State private var viewModel: LeaguesViewModel
    private let onNavigateToEvents: (EventsParameters) -> Void

    init(
        viewModel: LeaguesViewModel,
        onNavigateToEvents: @escaping (EventsParameters) -> Void
    ) {
        self.viewModel = viewModel
        self.onNavigateToEvents = onNavigateToEvents
    }

    var body: some View {
        Group {
            switch viewModel.state.leaguesState {
            case .loading:
                LoadingView()

            case .success:
                LeagueList(leagues: viewModel.filteredLeagues) { league in
                    onNavigateToEvents(
                        .init(
                            sportType: league.sportType,
                            leagueId: league.id
                        )
                    )
                }

            case .empty:
                EmptyStateView(
                    message: L10n.Leagues.empty(viewModel.sportType.title),
                    iconSystem: viewModel.sportType.icon
                )
            case .failure(let message):
                ErrorView(
                    message: message,
                    onRetry: {
                        viewModel.getLeagues()
                    }
                )
            }
        }
        .background(AppColors.background)
        .navigationTitle(L10n.Leagues.title(viewModel.sportType.title))
        .navigationBarTitleDisplayMode(.inline)
        .customBackButton(
            tintColor: .green,
            backgroundColor: AppColors.backButtonBackground,
            backgroundShadowColor: AppColors.foreground.opacity(0.3)
        )
        .searchable(text: $viewModel.searchText)
        .task {
            viewModel.getLeagues()
        }
        .onDisappear {
            viewModel.cancelAllTasks()
        }
    }
}

