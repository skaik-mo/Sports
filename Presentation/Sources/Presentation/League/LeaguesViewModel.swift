//
//  LeaguesViewModel.swift
//  Presentation
//
//  Created by Mohammed Skaik on 08/07/2026.
//

import Foundation
import Domain

@Observable
@MainActor
public final class LeaguesViewModel: BaseViewModel<[LeagueUI]> {
    private var getAllLeaguesUseCase: GetAllLeaguesUseCase
    private(set) var sportType: SportType
    var searchText: String = ""
    var filteredLeagues: [LeagueUI] {
        guard case .success(let leagues) = state else { return [] }
        guard !searchText.isEmpty else { return leagues }
        return leagues.filter {
            $0.leagueName.localizedCaseInsensitiveContains(searchText) ||
            $0.countryName.localizedCaseInsensitiveContains(searchText)
        }
    }

    public init(
        sportType: SportType,
        getAllLeaguesUseCase: GetAllLeaguesUseCase
    ) {
        self.sportType = sportType
        self.getAllLeaguesUseCase = getAllLeaguesUseCase
    }


}

extension LeaguesViewModel {
    func getLeagues() async {
        await safeCall {
            try await self.getAllLeaguesUseCase
                .execute(sportType: self.sportType)
                .toUIModels()
        }
    }
}
