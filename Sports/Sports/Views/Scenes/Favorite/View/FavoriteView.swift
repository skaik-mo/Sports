//
//  FavoriteView.swift
//  Sports
//
//  Created by Mohammed Skaik on 28/09/2024.
//

import SwiftUI

struct FavoriteView: View {
    @Environment(\.modelContext) private var modelContext
    @State var viewModel: FavoriteViewModel
    @State var isExpanded: Bool = true

    init(viewModel: FavoriteViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        LeaguesList()
            .background(Color.background)
            .navigationTitle(viewModel.title)
            .searchable(text: $viewModel.searchText)
            .onAppear {
            viewModel.dataService.modelContext = modelContext
            viewModel.fetchFavorites()
        }
            .refreshable {
            viewModel.fetchFavorites()
        }
    }

}

extension FavoriteView {

    private func EmptyItemView() -> some View {
        VStack {
            Spacer(minLength: (UIScreen.screenHeight / 2) - 250)
            ContentUnavailableView(viewModel.emptyDataTitle, systemImage: viewModel.emptyDataImage)
        }
    }

    func SwipeButton(_ favorite: Favorite) -> some View {
        return Button(role: .destructive) {
            viewModel.deleteFavorite(favorite)
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }

    private func LeagueSectionView(_ favorites: [Favorite]) -> some View {
        ForEach(favorites) { favorite in
            Button {
                viewModel.navigateToEvents(favorite)
            } label: {
                LeagueCell(league: favorite.league)
            }
                .swipeActions {
                SwipeButton(favorite)
            }
        }
    }

    private func LeaguesList() -> some View {
        return List {
            Group {
                if viewModel.favoritesFilter.isEmpty {
                    EmptyItemView()
                } else {
                    ForEach(viewModel.favoritesFilter.groupBySport(), id: \.0) { sport, favorites in
                        Section {
                            LeagueSectionView(favorites)
                        } header: {
                            Text(sport.uppercased())
                                .foregroundStyle(Color.foreground)
                                .font(.custom("Poppins-Bold", size: 16))
                        }
                    }
                }
            }
                .listRowInsets(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .listRowBackground(Color.background)
                .listRowSeparator(.hidden)
        }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .listSectionSpacing(0)
            .safeAreaPadding(.bottom, 100)
    }
}

#Preview {
    let coordinator = DefaultCoordinator()
    let viewModel = FavoriteViewModel(coordinator: coordinator)
    return CustomNavView(coordinator: coordinator) {
        FavoriteView(viewModel: viewModel)
    }
}
