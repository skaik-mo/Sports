//
//  CustomTabBar.swift
//  Presentation
//
//  Created by Mohammed Skaik on 30/07/2026.
//

import SwiftUI
import DesignSystem

struct CustomTabBar: View {
    @Binding var selectedTab: TabRoute
    @Namespace private var animation

    var body: some View {
        HStack(spacing: AppSpacing.sm) {
            ForEach(TabRoute.allCases, id: \.self) { tab in
                tabButton(for: tab)
            }
        }
        .padding(AppSpacing.sm)
        .background(
            Capsule().fill(AppColors.primary.opacity(0.4))
        )
        .fixedSize(horizontal: false, vertical: true)
    }

    @ViewBuilder
    private func tabButton(for tab: TabRoute) -> some View {
        let isSelected = selectedTab == tab

        Button {
            withAnimation(.easeInOut(duration: 0.25)) {
                selectedTab = tab
            }
        } label: {
            HStack(spacing: AppSpacing.sm) {
                Spacer()
                Image(systemName: tab.icon)
                    .font(AppFonts.medium20)

                if isSelected {
                    Text(tab.title)
                        .font(AppFonts.medium14)
                        .transition(.opacity)
                }
                Spacer()
            }
            .foregroundStyle(AppColors.white)
            .padding(.vertical, AppSpacing.lg)
            .background {
                if isSelected {
                    Capsule()
                        .fill(AppColors.primary.opacity(0.9))
                        .matchedGeometryEffect(id: "selectedTab", in: animation)
                }
            }
        }
        .accessibilityLabel(tab.title)
        .accessibilityAddTraits(isSelected ? [.isSelected] : [])
    }
}
