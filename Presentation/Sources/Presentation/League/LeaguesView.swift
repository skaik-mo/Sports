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

    init(viewModel: LeaguesViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Group {
            switch viewModel.state.leaguesState {
            case .loading:
                LoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .success:
                LeagueList(leagues: viewModel.filteredLeagues) { league in
                    viewModel.didSelectLeague(league)
                }
                .refreshable {
                    viewModel.getLeagues(withLoading: false)
                }

            case .empty:
                ScrollView(.vertical) {
                    EmptyStateView(
                        message: L10n.Leagues.empty(viewModel.sportType.title),
                        iconSystem: viewModel.sportType.icon
                    )
                    .containerRelativeFrame([.horizontal, .vertical])
                }
                .refreshable {
                    viewModel.getLeagues(withLoading: false)
                }
            case .failure(let message):
                ErrorView(
                    message: message,
                    onRetry: {
                        viewModel.getLeagues()
                    }
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background(AppColors.background)
        .navigationTitle(L10n.Leagues.title(viewModel.sportType.title))
        .navigationBarTitleDisplayMode(.inline)
        .customBackButton(
            tintColor: AppColors.primary,
            backgroundColor: AppColors.backButtonBackground,
            backgroundShadowColor: AppColors.foreground.opacity(0.3)
        )
        .searchable(
            text:
                Binding(
                    get: { viewModel.state.searchText },
                    set: {
                        viewModel.updateState(key: \.searchText, to: $0)
                    }
                )
        )
        .onFirstAppear {
            viewModel.getLeagues()
        }
        .onDisappear {
            viewModel.cancelAllTasks()
        }
    }
}
