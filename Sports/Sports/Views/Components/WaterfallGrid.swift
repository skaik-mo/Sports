//
//  WaterfallGrid.swift
//  Sports
//
//  Created by Mohammed Skaik on 03/10/2024.
//

import SwiftUI

struct WaterfallGrid<Content: View>: View {
    private let spacing: CGFloat = 20
    @Binding var columns: [GridItem]
    @ViewBuilder private let content: () -> Content

    init(columns: Binding<[GridItem]>, @ViewBuilder content: @escaping () -> Content) {
        self._columns = columns
        self.content = content
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: spacing) {
                content()
            }
                .padding(spacing)
        }
    }
}
