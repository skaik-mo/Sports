//
//  LeagueCell.swift
//  Sports
//
//  Created by Mohammed Skaik on 24/10/2024.
//

import SwiftUI

struct LeagueCell: View {
    let league: League

    var body: some View {
        HStack(spacing: 20) {
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
}

