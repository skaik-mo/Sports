//
//  CustomTabBarView.swift
//  Sports
//
//  Created by Mohammed Skaik on 28/09/2024.
//

import SwiftUI

struct CustomTabBarView: View {
    @State var selectedTab: TabbedItems = .home

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        UITabBar.appearance().standardAppearance = appearance
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(TabbedItems.home)
                FavoriteView()
                    .tag(TabbedItems.favorite)
            }
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

#Preview {
    CustomTabBarView()
}
