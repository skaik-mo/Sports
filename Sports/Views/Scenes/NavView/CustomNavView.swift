//
//  CustomNavView.swift
//  Sports
//
//  Created by Mohammed Skaik on 03/10/2024.
//

import SwiftUI

struct CustomNavView<Content: View>: View {

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        NavigationStack {
            content
                .navigationAppearance(backgroundColor: .background, foregroundColor: .main, hideSeparator: true)
        }
    }
}

#Preview {
    CustomNavView()
    {
        Color.yellow.ignoresSafeArea()
            .navigationTitle("Welcome")
    }

}
