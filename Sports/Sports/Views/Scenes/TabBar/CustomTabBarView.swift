//
//  CustomTabBarView.swift
//  Sports
//
//  Created by Mohammed Skaik on 28/09/2024.
//

import SwiftUI

struct CustomTabBarView: View {
    @State private var selectedTab: TabbedItems = .home
    @StateObject private var homeCoordinator = DefaultCoordinator()
    @StateObject private var favoriteCoordinator = DefaultCoordinator()

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                CustomNavView(coordinator: homeCoordinator) {
                    HomeView(viewModel: .init(coordinator: homeCoordinator))
                }
                    .tag(TabbedItems.home)
                    .toolbar(.hidden, for: .tabBar)

                CustomNavView(coordinator: favoriteCoordinator) {
                    FavoriteView(viewModel: .init(coordinator: favoriteCoordinator))
                }
                    .tag(TabbedItems.favorite)
                    .toolbar(.hidden, for: .tabBar)

            }
            if (homeCoordinator.path.isEmpty && selectedTab == .home) || (favoriteCoordinator.path.isEmpty && selectedTab == .favorite) {
                ZStack {
                    HStack {
                        ForEach((TabbedItems.allCases), id: \.self) { item in
                            CustomTabItem(tabbedItem: item, isActive: (selectedTab == item), selectedTab: $selectedTab)
                        }
                    }
                        .padding(5)
                }
                    .frame(height: 70)
                    .background(.main.opacity(0.2))
                    .cornerRadius(radius: 35)
                    .padding(.horizontal, 15)
            }
        }
    }
}

#Preview {
    CustomTabBarView()
}
