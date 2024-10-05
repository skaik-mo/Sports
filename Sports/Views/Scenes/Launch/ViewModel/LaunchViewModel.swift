//
//  LaunchViewModel.swift
//  Sports
//
//  Created by Mohammed Skaik on 28/09/2024.
//

import SwiftUI

@Observable
class LaunchViewModel {
    var isAnimating = true
    var isShowing = false
    let radius = (UIScreen.screenWidth - 60) / 3
    let lineWidth: CGFloat = 4

    func onAppear() {
        withAnimation(.spring(duration: 0.5, bounce: 0.5).repeatCount(1).delay(0.7)) {
            isAnimating = false
        } completion: {
            withAnimation {
                self.isAnimating = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                withAnimation {
                    self.isShowing = true
                }
            }
        }
    }

}
