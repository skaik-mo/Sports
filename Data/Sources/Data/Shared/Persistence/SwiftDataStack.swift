//
//  SwiftDataStack.swift
//  Data
//
//  Created by Mohammed Skaik on 14/06/2026.
//

import SwiftData

@MainActor
public final class SwiftDataStack {

    public static let shared = SwiftDataStack()

    let container: ModelContainer

    public var mainContext: ModelContext {
        container.mainContext
    }

    private init() {
        let schema = Schema([
            LeagueCache.self,
            EventCache.self,
            ParticipantCache.self,
            FavoriteCache.self,
        ])

        let config = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )

        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError(
                "Could not initialize SwiftData ModelContainer: \(error.localizedDescription)"
            )
        }
    }

}
