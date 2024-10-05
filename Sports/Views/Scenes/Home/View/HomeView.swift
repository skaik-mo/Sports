//
//  HomeView.swift
//  Sports
//
//  Created by Mohammed Skaik on 28/09/2024.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()

    init() {
        setUpSegmentedControl()
    }

    var body: some View {
        CustomNavView {
            WaterfallGrid(columns: $viewModel.columns) {
                SportShapeStack(viewModel.sports.split().left)
                SportShapeStack(viewModel.sports.split().right)
            }.animation(.linear(duration: 0.15), value: viewModel.isWaterfall)
                .navigationTitle("All Sports")
                .background(Color.background)
                .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Picker("Grid Style", selection: $viewModel.isWaterfall) {
                        Button(action: {
                            viewModel.isWaterfall = true
                        }, label: {
                                Image(systemName: "square.grid.2x2")
                                    .symbolVariant(viewModel.isWaterfall ? .fill : .none)
                                    .background(.red)
                                    .foregroundStyle(.red)
                            }).tag(true)
                        Button(action: {
                            viewModel.isWaterfall = false
                        }, label: {
                                Image(systemName: "rectangle.grid.1x2")
                                    .symbolVariant(viewModel.isWaterfall ? .none : .fill)
                                    .background(.red)
                                    .foregroundStyle(.red)
                            }).tag(false)
                    }.pickerStyle(.segmented)
                }
            }
        }

    }

}

// MARK: - Shapes
extension HomeView {
    private func SportShapeStack(_ sports: [Sports]) -> some View {
        LazyVStack(spacing: viewModel.spacing) {
            ForEach(sports) { sport in
                NavigationLink {
                    LeaguesView(viewModel: .init(sport: sport))
                } label: {
                    LazyVStack {
                        Image(sport.image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: viewModel.heightImage)
                        Text(sport.title)
                            .font(viewModel.font)
                            .foregroundStyle(Color.foreground)
                    }
                        .padding(viewModel.spacing)
                        .background(.secondaryBackground)
                        .cornerRadius(radius: 20)
                        .shadow(color: .shadow, radius: 5, x: 0, y: 2)
                }
            }
        }
    }
}

extension HomeView {
    private func setUpSegmentedControl() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .main
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.foreground], for: .normal)
    }
}

#Preview {
    HomeView()
}
