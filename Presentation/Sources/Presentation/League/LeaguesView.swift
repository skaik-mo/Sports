//
//  LeaguesView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 08/07/2026.
//

import SwiftUI
import DesignSystem

public struct LeaguesView: View {
    @State private var viewModel: LeaguesViewModel

    public init(viewModel: LeaguesViewModel) {
        self._viewModel = State(initialValue: viewModel)
    }

    public var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                LoadingView()

            case .success:
                LeagueList(leagues: viewModel.filteredLeagues) { league in
                    // handle navigate to Event Screen
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
                        Task { await viewModel.getLeagues() }
                    }
                )
            }
        }
        .background(AppColors.background)
        .navigationTitle(L10n.Leagues.title(viewModel.sportType.title))
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $viewModel.searchText)
        .task {
            await viewModel.getLeagues()
        }
    }
}

