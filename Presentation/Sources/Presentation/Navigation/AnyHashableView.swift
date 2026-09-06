//
//  AnyHashableView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 16/08/2026.
//

import SwiftUI

struct AnyHashableView: Hashable {
    let id: AnyHashable
    let view: AnyView

    static func == (lhs: borrowing AnyHashableView, rhs: borrowing AnyHashableView) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
