//
//  CustomNavView.swift
//  Sports
//
//  Created by Mohammed Skaik on 03/10/2024.
//

import SwiftUI

struct CustomNavView<Coordinator: RoutableCoordinator, Root: View>: View {
    @StateObject private var coordinator: Coordinator
    @ViewBuilder private let root: Root

    init(coordinator: Coordinator, root: @escaping () -> Root) {
        self._coordinator = StateObject(wrappedValue: coordinator)
        self.root = root()
    }

//    var body: some View {
//        NavigationStack {
//            content
//                .navigationAppearance(backgroundColor: .background, foregroundColor: .main, hideSeparator: true)
//        }
//    }

    var body: some View {
        NavigationStack(
            path: $coordinator.path,
            root: {
                root
                    .navigationAppearance(backgroundColor: .background, foregroundColor: .main, hideSeparator: true)
                    .navigationDestination(for: Coordinator.Route.self) { route in
                    coordinator.view(for: route)
                }
                    .fullScreenCover(
                    item: Binding(
                        get: { coordinator.modal?.asFullScreen() },
                        set: { coordinator.modal = $0 }
                    ),
                    content: { modal in coordinator.view(for: modal.route) }
                )
                    .sheet(
                    item: Binding(
                        get: { coordinator.modal?.asSheet() },
                        set: { coordinator.modal = $0 }
                    ),
                    content: { modal in coordinator.view(for: modal.route) }
                )
            }
        )
    }
}

#Preview {
    CustomNavView(coordinator: DefaultCoordinator())
    {
        Color.yellow.ignoresSafeArea()
            .navigationTitle("Welcome")
    }

}
