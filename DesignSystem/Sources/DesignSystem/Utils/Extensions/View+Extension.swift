//
//  View.swift
//  DesignSystem
//
//  Created by Mohammed Skaik on 29/06/2026.
//

import SwiftUI

extension View {

    func radius(radius: CGFloat, style: RoundedCornerStyle = .continuous) -> some View {
        self.clipShape(RoundedRectangle(cornerRadius: radius, style: style))
    }

    func radiusWithBorder(
        radius: CGFloat,
        borderColor: Color,
        lineWidth: CGFloat = 1,
        style: RoundedCornerStyle = .continuous
    ) -> some View {
        self.clipShape(RoundedRectangle(cornerRadius: radius, style: style))
            .overlay {
                RoundedRectangle(cornerRadius: radius, style: style)
                    .stroke(borderColor, lineWidth: lineWidth)
            }
    }
}
