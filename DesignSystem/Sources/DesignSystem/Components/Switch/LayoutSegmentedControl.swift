//
//  LayoutSegmentedControl.swift
//  DesignSystem
//
//  Created by Mohammed Skaik on 29/06/2026.
//

import SwiftUI

public protocol SegmentedLayoutOption: Hashable, CaseIterable {
    var systemImage: String { get }
}

public struct LayoutSegmentedControl<Option: SegmentedLayoutOption>: View {
    @Binding public var selection: Option
    @Namespace private var namespace

    private let animation = Animation.spring(
        response: 0.3,
        dampingFraction: 0.8
    )

    public init(selection: Binding<Option>) {
        self._selection = selection
    }

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(Option.allCases), id: \.self) { option in
                segment(
                    isActive: selection == option,
                    systemImage: option.systemImage
                ) {
                    withAnimation(animation) {
                        selection = option
                    }
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

