//
//  FavoriteDataService.swift
//  Sports
//
//  Created by Mohammed Skaik on 24/10/2024.
//

import SwiftData
import Foundation

class FavoriteDataService {
    var modelContext: ModelContext?
    var favorites: [Favorite] = []

    func addFavorite(_ favorite: Favorite) {
        modelContext?.insert(favorite)
        fetchFavorites()
    }

    func deleteFavorite(_ favorite: Favorite) {
        modelContext?.delete(favorite)
        fetchFavorites()
    }

    func setFavorite(_ favorite: Favorite) {
        if let favoriteExists = checkIfFavoriteExists(favorite) {
            deleteFavorite(favoriteExists)
        } else {
            addFavorite(favorite)
        }
    }

    func fetchFavorites() {
        let sortOrder: SortDescriptor<Favorite> = SortDescriptor(\.league.league_name)
        let descriptor = FetchDescriptor<Favorite>(sortBy: [sortOrder])
        let favorites = fetchFavorites(descriptor: descriptor)
        self.favorites = favorites
    }

    private func fetchFavorites(descriptor: FetchDescriptor<Favorite>) -> [Favorite] {
        do {
            let favorites = try modelContext?.fetch(descriptor) ?? []
            return favorites
        } catch {
            fatalError("Favorites failed =>> \(error.localizedDescription)")
        }
    }


    func checkIfFavoriteExists(_ favorite: Favorite) -> Favorite? {
        let league_key = favorite.id
        var descriptor = FetchDescriptor<Favorite>()
        descriptor.predicate = #Predicate<Favorite> {
            return $0.id == league_key
        }
        return fetchFavorites(descriptor: descriptor).first
    }

}
