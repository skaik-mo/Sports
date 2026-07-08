//
//  LeagueList.swift
//  Presentation
//
//  Created by Mohammed Skaik on 08/07/2026.
//

import SwiftUI
import DesignSystem

struct LeagueList: View {
    var leagues: [LeagueUI]
    let onTap: (LeagueUI) -> Void

    var body: some View {
        List(leagues) { league in
            LeagueCard(
                logo: league.leagueLogo,
                leagueName: league.leagueName,
                countryName: league.countryName
            )
            .listRowBackground(AppColors.clear)
            .listRowSeparator(.hidden)
            .listRowInsets(
                EdgeInsets(top: AppSpacing.md, leading: AppSpacing.xl, bottom: AppSpacing.md, trailing: AppSpacing.xl)
            )
            .onTapGesture {
                onTap(league)
            }
        }

        .listStyle(.plain)
        .scrollIndicators(.hidden)
    }
}
