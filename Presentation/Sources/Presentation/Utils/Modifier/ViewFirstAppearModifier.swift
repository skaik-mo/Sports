//
//  ViewFirstAppearModifier.swift
//  Presentation
//
//  Created by Mohammed Skaik on 01/08/2026.
//

import SwiftUI

struct ViewFirstAppearModifier: ViewModifier {
    @State private var didAppearBefore = false
    private let action: () -> Void

    init(perform action: @escaping () -> Void) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didAppearBefore == false {
                didAppearBefore = true
                action()
            }
        }
    }
}

public extension View {
    func onFirstAppear(perform action: @escaping () -> Void) -> some View {
        modifier(ViewFirstAppearModifier(perform: action))
    }
}
