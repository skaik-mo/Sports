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
//    var favorites: [Favorite] = []
    var favoritesGroup: [FavoriteGroup] = []
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

    func setFavorites() {
        originalFavorites = dataService.favorites
        //        favorites = originalFavorites
        favoritesGroup = originalFavorites.groupBySport()
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
            favoritesGroup = originalFavorites.groupBySport()
            return
        }
        let favoritesFiltered = originalFavorites.filter { $0.league.league_name?.lowercased().contains(searchText.lowercased()) ?? false }
        favoritesGroup = favoritesFiltered.groupBySport()
    }

    func deleteFavorite(_ indexSet: IndexSet, _ sport: String) {
        guard let sectionIndex = favoritesGroup.firstIndex(where: { $0.sport == sport }) else { return }

        indexSet.forEach { index in
            let favorite = favoritesGroup[sectionIndex].favorites[index]
            dataService.deleteFavorite(favorite)
        }

        favoritesGroup[sectionIndex].favorites.remove(atOffsets: indexSet)

        withAnimation {
            // Remove the section if it's empty
            if favoritesGroup[sectionIndex].favorites.isEmpty {
                favoritesGroup.remove(at: sectionIndex)
            }
        }

    }
}
