//
//  LeaguesViewModel.swift
//  Presentation
//
//  Created by Mohammed Skaik on 08/07/2026.
//

import Foundation
import Domain

public final class LeaguesViewModel: BaseViewModel<LeagueState> {
    private var getAllLeaguesUseCase: GetAllLeaguesUseCase
    private(set) var sportType: SportType
    var searchText: String = ""
    var filteredLeagues: [LeagueUI] {
        guard case .success(let leagues) = state.leaguesState else { return [] }
        guard !searchText.isEmpty else { return leagues }
        return leagues.filter {
            $0.leagueName.localizedCaseInsensitiveContains(searchText) ||
            $0.countryName.localizedCaseInsensitiveContains(searchText)
        }
    }

    private enum TaskID: String {
        case leagues
    }

    public init(
        sportType: SportType,
        getAllLeaguesUseCase: GetAllLeaguesUseCase
    ) {
        self.sportType = sportType
        self.getAllLeaguesUseCase = getAllLeaguesUseCase
        super.init(initialState: LeagueState())
    }

}

extension LeaguesViewModel {

    func getLeagues() {
        tryToExecute(
            id: TaskID.leagues.rawValue,
            onFailure: getLeagueFailure(),
            onSuccess: getLeagueSuccess()
        ){ [weak self] in
            guard let self else { throw DomainException.unknown }
            return try await self.getAllLeaguesUseCase
                .execute(sportType: self.sportType)
                .toUIModels()
        }
    }

    private func getLeagueSuccess() -> ([LeagueUI]) -> Void {
        return { [weak self] leagues in
            self?.updateState(
                key: \.leaguesState,
                to: leagues.isEmpty ? .empty : .success(leagues)
            )
        }
    }

    private func getLeagueFailure() -> (Error) -> Void {
        return { [weak self] error in
            self?.updateState(
                key: \.leaguesState,
                to: .failure(error.localizedDescription)
            )
        }
    }
}
