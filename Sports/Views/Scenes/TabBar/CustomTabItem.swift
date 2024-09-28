//
//  CustomTabItem.swift
//  Sports
//
//  Created by Mohammed Skaik on 28/09/2024.
//

import SwiftUI

struct CustomTabItem: View {
    var tabbedItem: TabbedItems
    var isActive: Bool
    @Binding var selectedTab: TabbedItems

    var body: some View {
        Button {
            selectedTab = tabbedItem
        } label: {
            HStack(spacing: 10) {
                Spacer()
                Image(systemName: tabbedItem.iconName)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(isActive ? .white : .gray)
                    .frame(width: 24, height: 24)
                if isActive {
                    Text(tabbedItem.title)
                        .font(.system(size: 14))
                        .foregroundColor(isActive ? .white : .gray)
                }
                Spacer()
            }
            .frame(width: .infinity, height: 60)
            .background(isActive ? .main.opacity(0.9) : .clear)
            .cornerRadius(radius: 30)
        }
    }
}

#Preview {
    CustomTabItem(tabbedItem: .home, isActive: true, selectedTab: .constant(.home))
}
