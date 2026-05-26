//
//  LaunchView.swift
//  Sports
//
//  Created by Mohammed Skaik on 28/09/2024.
//

import SwiftUI

struct LaunchView: View {

    @State var viewModel = LaunchViewModel()

    var body: some View {
        if viewModel.isShowing {
            CustomTabBarView()
        } else {
            ZStack {
                Color.background.ignoresSafeArea()
                CircleShape(.init("0096E6"))
                    .padding(.trailing, viewModel.isAnimating ? (viewModel.radius * 2) + (viewModel.lineWidth * 2) + 20: 0)
                CircleShape(.init("E64B3C"))
                    .padding(.leading, viewModel.isAnimating ? (viewModel.radius * 2) + (viewModel.lineWidth * 2) + 20: 0)
                CircleShape(.init("23AE5F"), isTopPadding: true)
                    .padding(.leading, viewModel.isAnimating ? (((viewModel.radius * 2) + (viewModel.lineWidth * 2) + 20) / 2) : 0)
                CircleShape(.init("F3D55B"), isTopPadding: true)
                    .padding(.trailing, viewModel.isAnimating ? (((viewModel.radius * 2) + (viewModel.lineWidth * 2) + 20) / 2) : 0)
                CircleShape(.init("38454F"))
            }.onAppear(perform: viewModel.onAppear)
        }
    }

    private func CircleShape(_ color: Color, isTopPadding: Bool = false) -> some View {
        let lineWidth: CGFloat = viewModel.lineWidth
        let radius: CGFloat = viewModel.radius
        var topPadding: CGFloat = 0
        if isTopPadding {
            topPadding = viewModel.isAnimating ? radius - (lineWidth * 2): 0
        }
        return Circle()
            .stroke(color, lineWidth: lineWidth)
            .frame(width: radius, height: radius)
            .padding(.top, topPadding)
    }
}

#Preview {
    LaunchView()
}
