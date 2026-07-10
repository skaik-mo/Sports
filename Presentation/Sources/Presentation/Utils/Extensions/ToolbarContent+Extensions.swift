//
//  ToolbarContent+Extensions.swift
//  Presentation
//
//  Created by Mohammed Skaik on 29/06/2026.
//

import SwiftUI

extension ToolbarContent {
    @ToolbarContentBuilder
    func hideSharedBackgroundIfAvailable() -> some ToolbarContent {
        if #available(iOS 26, *) {
            self.sharedBackgroundVisibility(.hidden)
        } else {
            self
        }
    }
}
