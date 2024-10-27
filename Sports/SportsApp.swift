//
//  SportsApp.swift
//  Sports
//
//  Created by Mohammed Skaik on 28/09/2024.
//

import SwiftUI
import SwiftData

@main
struct SportsApp: App {
    @State var alert = AlertManager()
    @State var progress = ProgressManager()
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Favorite.self,
            ])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(sharedModelContainer)
                .environment(\.alertKey, alert)
                .environment(\.progressKey, progress)
                .errorAlert($alert)
                .overlay {
                if progress.showProgress {
                    CustomProgressView()
                }
            }
        }
    }

}
