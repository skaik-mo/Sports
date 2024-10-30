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

    private func LeaguesList() -> some View {
        return List {
            Group {
                if viewModel.favorites.isEmpty {
                    Spacer(minLength: (UIScreen.screenHeight / 2) - 250)
                    ContentUnavailableView(viewModel.emptyDataTitle, systemImage: viewModel.emptyDataImage)
                } else {
                    ForEach(viewModel.favorites) { favorite in
                        Button {
                            viewModel.navigateToEvents(favorite)
                        } label: {
                            LeagueCell(league: favorite.league)
                        }
                    }
                    .onDelete(perform: viewModel.deleteFavorite)
                }
            }
                .listRowInsets(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .listRowBackground(Color.background)
                .listRowSeparator(.hidden)
        }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
    }
}

#Preview {
    let coordinator = DefaultCoordinator()
    let viewModel = FavoriteViewModel(coordinator: coordinator)
    let league = League(league_key: 3, league_name: "UEFA Champions League", country_key: 1, country_name: "Eurocups", league_logo: "https://apiv2.allsportsapi.com/logo/logo_leagues/3_uefa_champions_league.png",
        country_logo: nil)
    let favorite = Favorite(league: league, sport: .football)
    viewModel.favorites.append(favorite)
    return CustomNavView(coordinator: coordinator) {
        FavoriteView(viewModel: viewModel)
    }
}
