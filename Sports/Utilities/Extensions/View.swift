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

// MARK: - Alert
extension View {
    func errorAlert(_ alert: Binding<AlertManager>) -> some View {
        self.alert(isPresented: alert.showAlert) {
            Alert(title: Text(alert.title.wrappedValue), message: Text(alert.message.wrappedValue), dismissButton: .destructive(Text("OK")))
        }
    }
}
