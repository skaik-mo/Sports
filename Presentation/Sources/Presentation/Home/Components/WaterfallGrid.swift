//
//  WaterfallGrid.swift
//  Presentation
//
//  Created by Mohammed Skaik on 01/07/2026.
//

import SwiftUI
import DesignSystem

struct WaterfallGrid<Content: View>: View {
     let columns: [GridItem]
    @ViewBuilder private let content: () -> Content

    init(
        columns: [GridItem],
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.columns = columns
        self.content = content
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: AppSpacing.lg) {
                content()
            }
            .padding(AppSpacing.lg)
        }
    }
}

