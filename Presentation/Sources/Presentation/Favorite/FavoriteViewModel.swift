//
//  FavoriteViewModel.swift
//  Presentation
//
//  Created by Mohammed Skaik on 15/07/2026.
//

import Domain

public final class FavoriteViewModel: BaseViewModel<FavoriteState> {
    private let getFavoritesUseCase: GetFavoritesUseCase
    private let removeFavoriteUseCase: RemoveFavoriteUseCase
    var filteredSections: [LeagueSection] {
        guard case .success(let sections) = state.favoriteState else {
            return []
        }
        return sections.filtered(by: state.searchText)
    }

    private enum TaskID: String {
        case favorites
        case remove

        func with(id: String) -> String {
            "\(rawValue)-\(id)"
        }
    }

    public init(
        getFavoritesUseCase: GetFavoritesUseCase,
        removeFavoriteUseCase: RemoveFavoriteUseCase
    ) {
        self.getFavoritesUseCase = getFavoritesUseCase
        self.removeFavoriteUseCase = removeFavoriteUseCase
        super.init(initialState: FavoriteState())
    }

}


extension FavoriteViewModel {
    func getFavorites() {
        tryToExecute(
            id: TaskID.favorites.rawValue,
            onFailure: getFavoritesFailure(),
            onSuccess: getFavoritesSuccess()
        ) { [weak self] in
            return try await self?.getFavoritesUseCase
                .execute()
                .toUIModels() ?? []
        }
    }

    private func getFavoritesSuccess() -> ([LeagueUIModel]) -> Void {
        return { [weak self] leagues in
            let leaguesSections = leagues.groupedBySportTypeSections()
            self?.updateState(
                key: \.favoriteState,
                to: leagues.isEmpty ? .empty : .success(leaguesSections)
            )
        }
    }

    private func getFavoritesFailure() -> (Error) -> Void {
        return { [weak self] error in
            self?.updateState(
                key: \.favoriteState,
                to: .failure(error.localizedDescription)
            )
        }
    }
}

extension FavoriteViewModel {
    func removeFavorite(league: LeagueUIModel) {
        let previousState = state.favoriteState
        removeLeagueFromState(league)

        tryToExecute(
            id: TaskID.favorites.rawValue,
            onFailure: {
                [weak self] error in self?
                    .onRemoveFavoritesFailure(
                        error: error,
                        previousState: previousState
                    )
            },
            onSuccess: {}
        ) { [weak self] in
            try await self?.removeFavoriteUseCase.execute(leagueId: league.id)
        }
    }

    private func onRemoveFavoritesFailure(
        error: DomainException,
        previousState: ViewState<[LeagueSection]>
    ){
        updateState(
            key: \.favoriteState,
            to: .failure(error.localizedDescription)
        )
    }

    private func removeLeagueFromState(_ league: LeagueUIModel) {
        guard case .success(let sections) = state.favoriteState else { return }

        let updatedSections = sections
            .map { section in
                guard section.sportType == league.sportType else {
                    return section
                }
                return LeagueSection(
                    sportType: section.sportType,
                    leagues: section.leagues.filter { $0.id != league.id }
                )
            }
            .filter { !$0.leagues.isEmpty }

        updateState(
            key: \.favoriteState,
            to: updatedSections.isEmpty ? .empty : .success(updatedSections)
        )
    }
}
