//
//  HomeView.swift
//  Sports
//
//  Created by Mohammed Skaik on 28/09/2024.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            WaterfallGrid(columns: $viewModel.columns) {
                SportShapeStack(viewModel.sports.split().left)
                SportShapeStack(viewModel.sports.split().right)
            }.animation(.linear(duration: 0.15), value: viewModel.isWaterfall)
                .navigationTitle("All Sports")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Switch") {
                            viewModel.isWaterfall.toggle()
                        }
                    }
                }
        }

    }

    private func SportShapeStack(_ sports: [Sports]) -> some View {
        LazyVStack(spacing: viewModel.spacing) {
            ForEach(sports) { sport in
                LazyVStack {
                    Image(sport.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: viewModel.heightImage)
                    Text(sport.title)
                        .font(viewModel.font)
                        .foregroundStyle(.black)
                }
                    .padding(viewModel.spacing)
                    .background(.white)
                    .cornerRadius(radius: 20)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
            }
        }
    }
}

#Preview {
    HomeView()
}
