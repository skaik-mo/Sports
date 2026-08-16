//
//  RouterProtocol.swift
//  Presentation
//
//  Created by Mohammed Skaik on 16/08/2026.
//

import Foundation
import SwiftUI

@MainActor
protocol RouterProtocol: AnyObject {
    var path: [AnyHashableView] { get set }

    func push(_ route: AnyHashableView)
    func pop()
    func popToRoot()
    func pop(to id: AnyHashable)
}

extension RouterProtocol {
    func push<ID: Hashable, RootContent: View>(
        id: ID,
        @ViewBuilder view: () -> RootContent
    ) {
        let route = AnyHashableView(id: id, view: AnyView(view()))
        push(route)
    }
}
