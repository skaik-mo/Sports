//
//  LayoutSegmentedControl.swift
//  DesignSystem
//
//  Created by Mohammed Skaik on 29/06/2026.
//

import SwiftUI

public struct LayoutSegmentedControl: View {
    @Binding public var showsGrid: Bool
    @Namespace private var namespace

    private let animation = Animation.spring(
        response: 0.3,
        dampingFraction: 0.8
    )

    public init(showsGrid: Binding<Bool>) {
        self._showsGrid = showsGrid
    }

    public var body: some View {
        HStack(spacing: 0) {
            segment(
                isActive: showsGrid,
                systemImage: AppIcon.grid2x2,
            ) {
                withAnimation(animation) {
                    showsGrid = true
                }
            }

            segment(
                isActive: !showsGrid,
                systemImage: AppIcon.list1x2,
            ) {
                withAnimation(animation) {
                    showsGrid = false
                }
            }
        }
        .padding(AppSpacing.xs)
        .background(AppColors.secondaryBackground)
        .radiusWithBorder(
            radius: AppRadius.medium,
            borderColor: AppColors.stroke,
            lineWidth: 0.5
        )
    }
}

private extension LayoutSegmentedControl {

    @ViewBuilder
    func segment(
        isActive: Bool,
        systemImage: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            ZStack {
                if isActive {
                    RoundedRectangle(cornerRadius: AppRadius.small)
                        .fill(AppColors.primary)
                        .matchedGeometryEffect(id: "background", in: namespace)
                }

                Image(systemName: systemImage)
                    .symbolVariant(isActive ? .fill : .none)
                    .foregroundStyle(
                        isActive ? AppColors.white : AppColors.foreground
                    )
            }
            .frame(width: 44, height: 32)
        }
        .buttonStyle(.plain)
    }
}


#Preview {
    @Previewable @State var isGrid = true
    ZStack {
        Color.gray.opacity(0.2).ignoresSafeArea()
        LayoutSegmentedControl(showsGrid: $isGrid)
    }
}
