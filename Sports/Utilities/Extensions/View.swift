//
//  View.swift
//  Sports
//
//  Created by Mohammed Skaik on 28/09/2024.
//

import SwiftUI

extension View {

    func cornerRadius(radius: CGFloat, corners: UIRectCorner = .allCorners) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }

    func roundedCornerWithBorder(lineWidth: CGFloat, borderColor: Color, radius: CGFloat, corners: UIRectCorner) -> some View {
        cornerRadius(radius: radius, corners: corners)
            .overlay(RoundedCorner(radius: radius, corners: corners)
                .stroke(borderColor, lineWidth: lineWidth))
    }
}
