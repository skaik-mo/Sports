//
//  FavoriteCache.swift
//  Data
//
//  Created by Mohammed Skaik on 14/07/2026.
//

import SwiftData
import Foundation

@Model
final class FavoriteCache {
    @Attribute(.unique)
    var id: Int

    init(id: Int) {
        self.id = id
    }
}
