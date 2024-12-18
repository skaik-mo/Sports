//
//  HomeViewModel.swift
//  Sports
//
//  Created by Mohammed Skaik on 29/09/2024.
//

import SwiftUI

@Observable
@MainActor
class HomeViewModel {
    let coordinator: Coordinator
    let sports = Sports.allCases
    let spacing: CGFloat = 20
    var columns: [GridItem]
    var heightImage: CGFloat? = nil
    var fontSize: CGFloat = 20
    var font: Font { .custom("Poppins-Medium", size: fontSize) }
    var isWaterfall = true {
        didSet {
            changeHeightImage()
            changeFontSize()
            changeColumns()
        }
    }

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        self.columns = [GridItem(.flexible(), spacing: spacing, alignment: .top), GridItem(.flexible(), spacing: spacing, alignment: .top)]
    }

    private func changeHeightImage() {
        heightImage = isWaterfall ? nil : 150
    }

    private func changeFontSize() {
        fontSize = isWaterfall ? 20 : 30
    }

    private func changeColumns() {
        columns = isWaterfall ? [GridItem(.flexible(), spacing: spacing, alignment: .top), GridItem(.flexible(), spacing: spacing, alignment: .top)]
        : [GridItem(.flexible())]
    }

    func navigateToLeagues(_ sport: Sports) {
        coordinator.navigateToLeagues(sport)
    }

}
