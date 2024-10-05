//
//  LeaguesView.swift
//  Sports
//
//  Created by Mohammed Skaik on 05/10/2024.
//

import SwiftUI

struct LeaguesView: View {

    @State var viewModel: LeaguesViewModel

    init(viewModel: LeaguesViewModel) {
        self._viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        List(viewModel.leagues) { league in
            HStack(spacing: 20) {
                AsyncImage(url: URL(string: league.league_logo ?? "")) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .roundedCornerWithBorder(lineWidth: 1, borderColor: .main, radius: 20, corners: .allCorners)
                    default:
                        Image(.logoOlympic)
                            .resizable()
                            .frame(width: 70, height: 70)
                            .roundedCornerWithBorder(lineWidth: 1, borderColor: .main, radius: 20, corners: .allCorners)
                    }
                }
                Text(league.league_name ?? "")
                    .font(.custom("Poppins-Medium", size: 14))
                    .foregroundStyle(Color.foreground)
                Spacer()
            }
                .padding(15)
                .background(.secondaryBackground)
                .listRowBackground(Color.background)
                .cornerRadius(radius: 20)
                .shadow(color: .shadow, radius: 5, x: 0, y: 2)
                .listRowInsets(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .listRowSeparator(.hidden)
        }
            .listStyle(.plain)
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.background)
            .scrollIndicators(.hidden)
    }
}

#Preview {
    let viewModel = LeaguesViewModel(sport: .football)
    viewModel.leagues.append(.init(league_key: 3, league_name: "UEFA Champions League", country_key: 1, country_name: "Eurocups", league_logo: "https://apiv2.allsportsapi.com/logo/logo_leagues/3_uefa_champions_league.png",
        country_logo: nil))
    return LeaguesView(viewModel: viewModel)

}
