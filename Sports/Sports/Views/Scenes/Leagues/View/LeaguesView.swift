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
            .onFirstAppear {
            self.viewModel.setAlertManagerAndProgressManager(alert: alertManager, progress: progressManager)
            self.viewModel.fetchLeagues()
        }
            .refreshable {
            self.viewModel.fetchLeagues(isShowLoader: false)
        }
    }
}

extension LeaguesView {

    private func LeaguesList() -> some View {
        return List {
            Group {
                if viewModel.leagues.isEmpty && !progressManager.showProgress {
                    Spacer(minLength: (UIScreen.screenHeight / 2) - 150)
                    ContentUnavailableView(viewModel.emptyDataTitle, systemImage: viewModel.sport.icon)
                } else {
                    ForEach(viewModel.leagues) { league in
                        Button {
                            viewModel.navigateToEvents(league)
                        } label: {
                            LeagueCell(league: league)
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
    let coordinator = DefaultCoordinator()
    let viewModel = LeaguesViewModel(coordinator: coordinator, networkService: RequestBuilder(), sport: .football)
    viewModel.leagues.append(.init(league_key: 3, league_name: "UEFA Champions League", country_key: 1, country_name: "Eurocups", league_logo: "https://apiv2.allsportsapi.com/logo/logo_leagues/3_uefa_champions_league.png",
        country_logo: nil))
     return CustomNavView(coordinator: coordinator) {
        LeaguesView(viewModel: viewModel)
    }
}
