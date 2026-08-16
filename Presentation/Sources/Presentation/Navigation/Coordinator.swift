//
//  Coordinator.swift
//  Presentation
//
//  Created by Mohammed Skaik on 21/07/2026.
//

import Foundation

@MainActor
protocol Coordinator: AnyObject {
    var router: Router { get }
}

extension Coordinator {
    func pop() {
        router.pop()
    }

    func popToRoot() {
        router.popToRoot()
    }
}
