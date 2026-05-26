//
//  CircularProgressViewStyle.swift
//  Sports
//
//  Created by Mohammed Skaik on 06/10/2024.
//

import SwiftUI

public struct CircularProgressViewStyle: ProgressViewStyle {
    private let lineWidth: CGFloat = 8.0
    private let defaultProgress = 0.0
    private let color = Color.main

    public func makeBody(configuration: ProgressViewStyleConfiguration) -> some View {
        ZStack {
            progressCircleView(fractionCompleted: configuration.fractionCompleted ?? defaultProgress)
            Text(String(format: "%.0f%%", (configuration.fractionCompleted ?? 0) * 100))
                .bold()
        }
    }

    private func progressCircleView(fractionCompleted: Double) -> some View {
        Circle()
            .stroke(color, lineWidth: lineWidth)
            .opacity(0.2)
            .overlay(progressFill(fractionCompleted: fractionCompleted))
    }

    private func progressFill(fractionCompleted: Double) -> some View {
        Circle()
            .trim(from: 0, to: CGFloat(fractionCompleted))
            .stroke(color, style: StrokeStyle(
            lineWidth: lineWidth,
            lineCap: .round
            ))
            .rotationEffect(.degrees(-90))
    }
}


struct CircularLoderViewStyle: ProgressViewStyle {
    private let color = Color.main
    private let lineWidth: CGFloat = 8.0
    @State private var degree: Int = 270
    @State private var spinnerLength = 0.6

    func makeBody(configuration: Configuration) -> some View {
        Circle()
            .trim(from: 0.0, to: spinnerLength)
            .stroke(color, style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
            .animation(.easeIn(duration: 1.5).repeatForever(autoreverses: true), value: degree)
            .rotationEffect(Angle(degrees: Double(degree)))
            .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: spinnerLength)
            .onAppear {
            degree = 270 + 360
            spinnerLength = 0
        }
    }
}
