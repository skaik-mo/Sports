//
//  SportsApp.swift
//  Sports
//
//  Created by Mohammed Skaik on 28/09/2024.
//

import SwiftUI

@main
struct SportsApp: App {
    @State var alert = AlertManager()
    @State var progress = ProgressManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.alertKey, alert)
                .environment(\.progressKey, progress)
                .errorAlert($alert)
//                .sheet(isPresented: $progress.showProgress) {
            .overlay {
                if progress.showProgress {
                    CustomProgressView()
                }
            }
        }
    }
}
