//
//  LeaguesView.swift
//  Sports
//
//  Created by Mohammed Skaik on 05/10/2024.
//

import SwiftUI

struct LeaguesView: View {

    @State private var viewModel: LeaguesViewModel
    @Environment(\.alertKey) private var alertManager
    @Environment(\.progressKey) private var progressManager

    init(viewModel: LeaguesViewModel) {
        self._viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        LeaguesList()
            .background(Color.background)
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchText)
            .onAppear {
            self.viewModel.alertManager = alertManager
            self.viewModel.progressManager = progressManager
            self.viewModel.leagues.removeAll()
        }
            .task {
            self.viewModel.fetchLeagues()
        }
            .refreshable {
            self.viewModel.fetchLeagues(isShowLoader: false)
        }
    }
}

extension LeaguesView {
    private func LeagueCell(_ league: League) -> some View {
        return HStack(spacing: 20) {
            ImageLoadingView(url: league.league_logo)
                .frame(width: 70, height: 70)
            Text(league.league_name ?? "")
                .font(.custom("Poppins-Medium", size: 14))
                .foregroundStyle(Color.foreground)
            Spacer()
        }
            .padding(15)
            .background(.secondaryBackground)
            .cornerRadius(radius: 20)
            .shadow(color: .shadow, radius: 5, x: 0, y: 2)
    }

    private func LeaguesList() -> some View {
        return List {
            Group {
                if viewModel.leagues.isEmpty && !progressManager.showProgress {
                    Spacer(minLength: (UIScreen.screenHeight / 2) - 150)
                    ContentUnavailableView(, systemImage: viewModel.sport.icon)
                } else {
                    ForEach(viewModel.leagues) { league in
                        LeagueCell(league)
                            .navigationLink {
                                EventsView(.init(sport: viewModel.sport, leagueId: league.league_key))
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
    }
}

#Preview {
    let viewModel = LeaguesViewModel(sport: .football)
    viewModel.leagues.append(.init(league_key: 3, league_name: "UEFA Champions League", country_key: 1, country_name: "Eurocups", league_logo: "https://apiv2.allsportsapi.com/logo/logo_leagues/3_uefa_champions_league.png",
        country_logo: nil))
    return CustomNavView {
        LeaguesView(viewModel: viewModel)
    }
}
