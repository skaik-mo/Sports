//
//  NavigationLinkModifier.swift
//  Sports
//
//  Created by Mohammed Skaik on 08/10/2024.
//


import SwiftUI

struct NavigationLinkModifier<Destination: View>: ViewModifier {

    @ViewBuilder var destination: () -> Destination

    func body(content: Content) -> some View {
        content
            .background(
            NavigationLink(destination: self.destination) { EmptyView() }.opacity(0)
        )
    }
}

extension View {
    // MARK: - Use this when the item is inside a list. To hide the arrow
    func navigationLink<Destination: View>(_ destination: @escaping () -> Destination) -> some View {
        modifier(NavigationLinkModifier(destination: destination))
    }
}
