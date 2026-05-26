//
//  FavoriteViewModel.swift
//  Sports
//
//  Created by Mohammed Skaik on 18/10/2024.
//


import SwiftUI
import SwiftData

@Observable
class FavoriteViewModel {
    let coordinator: Coordinator
    let dataService = FavoriteDataService()
    private var favorites: [Favorite] = []
    private(set) var favoritesFilter: [Favorite] = []
    private(set) var title: String = "Favorite Leagues"
    private(set) var emptyDataImage: String = "sportscourt"
    private(set) var emptyDataTitle: String = "No Favorite Leagues Available"
    var searchText: String = "" {
        didSet {
            findFavorites()
        }
    }

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    private func setFavorites() {
        favorites = dataService.favorites
        favoritesFilter = favorites
    }

    func fetchFavorites() {
        dataService.fetchFavorites()
        setFavorites()
    }

    @MainActor
    func navigateToEvents(_ favorite: Favorite) {
        coordinator.navigateToEvents(favorite.sport, favorite.league)
    }

    private func findFavorites() {
        guard !searchText.isEmpty else {
            favoritesFilter = favorites
            return
        }
        let favoritesFiltered = favorites.filter { $0.league.league_name?.lowercased().contains(searchText.lowercased()) ?? false }
        favoritesFilter = favoritesFiltered
    }

    func deleteFavorite(_ favorite: Favorite) {
        withAnimation {
            dataService.deleteFavorite(favorite)
            setFavorites()
        }
    }
}
