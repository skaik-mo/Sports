//
//  EmptyStateView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 08/07/2026.
//

import SwiftUI
import DesignSystem

struct EmptyStateView: View {
    let message: String
    let iconSystem: String

    var body: some View {
        ContentStateView(
            message: message,
            iconSystem: iconSystem
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background)
    }
}


#Preview {
    EmptyStateView(
        message: "Empty Title",
        iconSystem: AppIcons.footballSystem
    )
}
