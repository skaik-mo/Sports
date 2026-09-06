//
//  Router.swift
//  Presentation
//
//  Created by Mohammed Skaik on 16/08/2026.
//

import Foundation
import SwiftUI
import Observation

@Observable
@MainActor
final class Router: RouterProtocol {
    var path: [AnyHashableView] = []

    init(path: [AnyHashableView] = []) {
        self.path = path
    }

    func push(_ route: AnyHashableView) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path.removeAll()
    }

    func pop(to id: AnyHashable) {
        guard let index = path.lastIndex(where: { element in
            element.id == id
        }) else {
            return
        }
        path.removeSubrange((index + 1)...)
    }
}
