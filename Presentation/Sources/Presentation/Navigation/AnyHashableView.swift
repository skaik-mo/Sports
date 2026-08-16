//
//  AnyHashableView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 16/08/2026.
//

import SwiftUI

public struct AnyHashableView: Hashable {
    public let id: AnyHashable
    public let view: AnyView

    public init(id: AnyHashable, view: AnyView) {
        self.id = id
        self.view = view
    }

    public static func == (lhs: AnyHashableView, rhs: AnyHashableView) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
