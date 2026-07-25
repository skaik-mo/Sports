//
//  SportsApp.swift
//  Sports
//
//  Created by Mohammed Skaik on 28/09/2024.
//

import SwiftUI
import SwiftData
import FactoryKit
import Presentation
import DesignSystem

@main
struct SportsApp: App {

    init() {
        DesignSystemFontLoader.registerFonts()
        Container.shared.registerViewModelDependency()
    }

    var body: some Scene {
        WindowGroup {
            AppRootCoordinatorView()
        }
    }

}
