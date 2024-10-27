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

    private func addFavorite(_ favorite: Favorite) {
        modelContext?.insert(favorite)
    }

    func setFavorite(_ favorite: Favorite) {
        if let favoriteExists = checkIfFavoriteExists(favorite) {
            deleteFavorite(favoriteExists)
        } else {
            addFavorite(favorite)
        }
    }

    func fetchFavorites(descriptor: FetchDescriptor<Favorite>) -> [Favorite] {
        do {
            let favorites = try modelContext?.fetch(descriptor) ?? []
            return favorites
        } catch {
            fatalError("Favorites failed =>> \(error.localizedDescription)")
        }
    }

    func deleteFavorite(_ favorite: Favorite) {
        debugPrint(#function)
        modelContext?.delete(favorite)
        do {
            try modelContext?.save()
        } catch let error {
            debugPrint("error =>> \(error)")
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
