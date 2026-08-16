//
//  RouterView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 16/08/2026.
//

import SwiftUI

struct RouterView<RootContent: View>: View {
    @Bindable var router: Router
    private let root: () -> RootContent

    init(
        router: Router,
        @ViewBuilder root: @escaping () -> RootContent
    ) {
        self.router = router
        self.root = root
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            root()
                .navigationDestination(
                    for: AnyHashableView.self
                ) { destination in
                    destination.view
                }
        }
    }
}
