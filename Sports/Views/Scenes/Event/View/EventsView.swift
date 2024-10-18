//
//  EventsView.swift
//  Sports
//
//  Created by Mohammed Skaik on 08/10/2024.
//

import SwiftUI

struct EventsView: View {
    @State private var viewModel: EventsViewModel
    @Environment(\.alertKey) private var alertManager
    @Environment(\.progressKey) private var progressManager

    init(viewModel: EventsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            if viewModel.isEmptyData {
                Spacer(minLength: (UIScreen.screenHeight / 2) - 150)
                ContentUnavailableView(viewModel.emptyDataTitle, systemImage: viewModel.sport.icon)
            } else {
                HorizontalScrollWithHeader(title: viewModel.upcomingTitle, events: viewModel.upcomingEvents) { event in
                    EventCell(event)
                }
                LatestEvents()
                HorizontalScrollWithHeader(title: viewModel.teamTitle, events: Array(viewModel.teams)) { team in
                    TeamCell(team)
                        .padding(viewModel.padding)
                        .background(.secondaryBackground)
                        .cornerRadius(radius: 20)
                        .shadow(color: .shadow, radius: 5, x: 0, y: 2)
                }
            }
        }
            .background(Color.background)
            .scrollIndicators(.hidden)
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.inline)
            .onFirstAppear {
            self.viewModel.alertManager = alertManager
            self.viewModel.progressManager = progressManager
            self.viewModel.clear()
            self.viewModel.fetchEvents()
        }
            .refreshable {
            self.viewModel.fetchEvents(isShowLoader: false)
        }
    }

}

extension EventsView {

    private func LatestEvents() -> some View {
        Group {
            if !viewModel.latestEvents.isEmpty {
                Section (header: HeaderCell(title: viewModel.latestTitle)) {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.latestEvents) { event in
                            EventCell(event)
                        }
                    }
                        .padding(.bottom, 20)
                }
            }
        }
    }

    private func TeamCell(_ team: Team?) -> some View {
        VStack(spacing: 5) {
            ImageLoadingView(url: team?.logo)
                .frame(width: 100, height: 100)
            Text(team?.name ?? "")
                .font(.custom("Poppins-Medium", size: 16))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.foreground)
        }
            .frame(width: 115, height: 150)
    }

    private func EventCell(_ event: Event) -> some View {
        VStack(spacing: 0) {
            Text(event.date ?? "")
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundStyle(.gray)
            HStack {
                TeamCell(event.team?.homeTeam)
                Spacer()
                VStack(spacing: 25) {
                    Text(viewModel.vsTitle)
                        .font(.custom("Poppins-Medium", size: 26))
                        .foregroundStyle(Color.foreground)
                    if let result = event.final_result, event.final_result != "-" {
                        Text(result)
                            .font(.custom("Poppins-Medium", size: 20))
                            .foregroundStyle(Color.foreground)
                    }
                }
                Spacer()
                TeamCell(event.team?.awayTeam)
            }
            Text(event.time ?? "")
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundStyle(.gray)
        }
            .padding(viewModel.padding)
            .background(.secondaryBackground)
            .cornerRadius(radius: 20)
            .shadow(color: .shadow, radius: 5, x: 0, y: 2)
            .frame(width: UIScreen.screenWidth - (viewModel.padding * 2))
    }

}

#Preview {
    let coordinator = DefaultCoordinator()
    let league = League.init(league_key: 3, league_name: "UEFA Champions League", country_key: 1, country_name: "Eurocups", league_logo: "https://apiv2.allsportsapi.com/logo/logo_leagues/3_uefa_champions_league.png",
        country_logo: nil)
    EventsView(viewModel: .init(coordinator: coordinator, sport: .football, league: league))
}
