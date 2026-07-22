//
//  LaunchView.swift
//  Sports
//
//  Created by Mohammed Skaik on 28/09/2024.
//

import SwiftUI
import DesignSystem

struct LaunchView: View {
    private struct RingConfig: Identifiable {
        let id = UUID()
        let color: Color
        let horizontalEdge: HorizontalEdge
        let isTopAligned: Bool
    }

    private enum HorizontalEdge {
        case leading, trailing, none
    }

    @State private var isAnimating = true
    @State private var didFinish = false
    private let lineWidth: CGFloat = 4
    private let circleSpacing: CGFloat = 20
    private let onFinished: () -> Void
    private let rings: [RingConfig] = [
        RingConfig(color: AppColors.blue, horizontalEdge: .trailing, isTopAligned: false),
        RingConfig(color: AppColors.orange, horizontalEdge: .leading, isTopAligned: false),
        RingConfig(color: AppColors.green, horizontalEdge: .leading, isTopAligned: true),
        RingConfig(color: AppColors.yellow, horizontalEdge: .trailing, isTopAligned: true),
        RingConfig(color: AppColors.black, horizontalEdge: .none, isTopAligned: false)
    ]

    init(onFinished: @escaping () -> Void) {
        self.onFinished = onFinished
    }

    var body: some View {
        GeometryReader { geometry in
            let radius = (geometry.size.width - 60) / 3
            let horizontalOffset = (radius * 2) + (lineWidth * 2) + circleSpacing
            ZStack {
                AppColors.background.ignoresSafeArea()

                ForEach(rings) { ring in
                    circleShape(
                        color: ring.color,
                        radius: radius,
                        topPadding: topPadding(for: ring, radius: radius)
                    )
                    .padding(.leading, ring.horizontalEdge == .leading ? sidePadding(for: ring, offset: horizontalOffset) : 0)
                    .padding(.trailing, ring.horizontalEdge == .trailing ? sidePadding(for: ring, offset: horizontalOffset) : 0)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .onAppear(perform: onAppear)
    }
}

extension LaunchView {
    private func onAppear() {
        guard !didFinish else { return }

        withAnimation(.spring(duration: 0.5, bounce: 0.5).delay(0.7)) {
            isAnimating = false
        } completion: {
            withAnimation {
                isAnimating = true
            }
            didFinish = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                onFinished()
            }
        }
    }
}

extension LaunchView {
    private func sidePadding(for ring: RingConfig, offset: CGFloat) -> CGFloat {
        guard isAnimating else { return 0 }
        return ring.isTopAligned ? offset / 2 : offset
    }

    private func topPadding(for ring: RingConfig, radius: CGFloat) -> CGFloat {
        guard ring.isTopAligned, isAnimating else { return 0 }
        return radius - (lineWidth * 2)
    }

    private func circleShape(color: Color, radius: CGFloat, topPadding: CGFloat) -> some View {
        Circle()
            .stroke(color, lineWidth: lineWidth)
            .frame(width: radius, height: radius)
            .padding(.top, topPadding)
    }
}


#Preview {
    LaunchView { }
}
