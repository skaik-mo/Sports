//
//  ContentStateView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 08/07/2026.
//

import SwiftUI
import DesignSystem

struct ContentStateView: View {
    let message: String
    let iconSystem: String

    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            Image(systemName: iconSystem)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .foregroundStyle(AppColors.primary)
            Text(message)
                .font(AppFonts.medium20)
                .foregroundStyle(AppColors.primaryText)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    ContentStateView(
        message: "Message",
        iconSystem: AppIcons.errorSystem
    )
}
