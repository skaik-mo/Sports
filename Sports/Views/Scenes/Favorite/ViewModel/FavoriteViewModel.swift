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
    private var originalFavorites: [Favorite] = []
    var favorites: [Favorite] = []
    var sport: Sports?
    var title: String = "Favorite Leagues"
    var emptyDataImage: String = "sportscourt"
    var emptyDataTitle: String = "No Favorite Leagues Available"
    var searchText: String = "" {
        didSet {
            findFavorites()
        }
    }

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func fetchFavorites() {
        dataService.fetchFavorites()
        originalFavorites = dataService.favorites
        favorites = originalFavorites
    }

    @MainActor
    func navigateToEvents(_ favorite: Favorite) {
        coordinator.navigateToEvents(favorite.sport, favorite.league)
    }

    private func findFavorites() {
        guard !searchText.isEmpty else {
            favorites = originalFavorites
            return
        }
        favorites = originalFavorites.filter { $0.league.league_name?.lowercased().contains(searchText.lowercased()) ?? false }
    }

    func deleteFavorite(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            dataService.deleteFavorite(favorites[index])
        }
    }

}
