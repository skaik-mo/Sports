//
//  SectionHeaderView.swift
//  DesignSystem
//
//  Created by Mohammed Skaik on 09/07/2026.
//

import SwiftUI

public struct SectionHeaderView: View {
    let title: String

    public init(title: String) {
        self.title = title
    }

    public var body: some View {
        Text(title)
            .font(AppFonts.bold24)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, AppSpacing.lg)
            .foregroundStyle(AppColors.primaryText)
    }
}

#Preview {
    SectionHeaderView(title: "Title")
}
