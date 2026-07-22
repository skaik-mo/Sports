//
//  MainTabView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 22/07/2026.
//

import SwiftUI

struct MainTabView: View {

    @State private var selectedTab: Tab = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeCoordinatorView()
                .tag(Tab.home)

            FavoriteCoordinatorView()
                .tag(Tab.favorite)
        }
    }
}
