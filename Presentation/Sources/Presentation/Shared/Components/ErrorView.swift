//
//  ErrorView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 08/07/2026.
//

import SwiftUI
import DesignSystem

struct ErrorView: View {
    let message: String
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: AppSpacing.xxl) {
            ContentStateView(
                message: message,
                iconSystem: AppIcons.errorSystem
            )
            Button(L10n.General.retry, action: onRetry)
                .font(AppFonts.medium16)
                .foregroundStyle(AppColors.white)
                .padding(.horizontal, AppSpacing.xxl)
                .padding(.vertical, AppSpacing.md)
                .background(AppColors.primary)
                .radius(radius: AppRadius.medium)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background)
    }
}


#Preview {
    ErrorView(message: "Errrorrr") { }
}
