//
//  CustomBackButton.swift
//  Presentation
//
//  Created by Mohammed Skaik on 26/07/2026.
//

import SwiftUI
import DesignSystem

struct CustomBackButton: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    let tintColor: Color
    let backgroundColor: Color
    let backgroundShadowColor: Color

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: AppIcons.chevronLeftSystem)
                            .foregroundStyle(tintColor)
                            .background(
                                Circle()
                                    .fill(backgroundColor)
                                    .frame(width: 32, height: 32)
                                    .shadow(
                                        color: backgroundShadowColor,
                                        radius: 4,
                                    )
                            )
                    }
                }
                .hideSharedBackgroundIfAvailable()
            }
    }
}

extension View {
    func customBackButton(tintColor: Color, backgroundColor: Color, backgroundShadowColor: Color) -> some View {
        self.modifier(
            CustomBackButton(
                tintColor: tintColor,
                backgroundColor: backgroundColor,
                backgroundShadowColor: backgroundShadowColor
            )
        )
    }
}
