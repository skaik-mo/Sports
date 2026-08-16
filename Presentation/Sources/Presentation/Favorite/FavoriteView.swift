//
//  FavoriteView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 15/07/2026.
//

import SwiftUI
import DesignSystem

struct FavoriteView: View {
    @State private var viewModel: FavoriteViewModel

    init(viewModel: FavoriteViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Group {
            switch viewModel.state.favoriteState {
            case .loading:
                LoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .failure(let message):
                ErrorView(
                    message: message,
                    onRetry: {
                        viewModel.getFavorites()
                    }
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .empty:
                ScrollView(.vertical) {
                    EmptyStateView(
                        message: L10n.Favorite.empty,
                        iconSystem: AppIcons.sportsCourtSystem
                    )
                    .containerRelativeFrame([.horizontal, .vertical])
                }
                .refreshable {
                    viewModel.getFavorites()
                }

            case .success:
                LeaguesSectionList(
                    sections: viewModel.filteredSections,
                    onTap: { league in
                        viewModel.didSelectLeague(league)
                    },
                    onRemove: { league in
                        viewModel.removeFavorite(league: league)
                    }
                )
                .refreshable {
                    viewModel.getFavorites()
                }
            }
        }
        .background(AppColors.background)
        .navigationTitle(L10n.Favorite.title)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(
            text:
                Binding(
                    get: { viewModel.state.searchText },
                    set: {
                        viewModel.updateState(key: \.searchText, to: $0)
                    }
                )
        )
        .task {
            viewModel.getFavorites()
        }
        .onDisappear {
            viewModel.cancelAllTasks()
        }
    }
}
