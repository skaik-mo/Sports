//
//  Color.swift
//  Sports
//
//  Created by Mohammed Skaik on 28/09/2024.
//

import SwiftUI

extension Color {
    /// Color.init(0x0096E6)
    init(_ hexColor: UInt64) {
        self.init(uiColor: .init(
            red: CGFloat(0xFF & (hexColor >> 0x10)) / 0xFF,
            green: CGFloat(0xFF & (hexColor >> 0x08)) / 0xFF,
            blue: CGFloat(0xFF & (hexColor >> 0x00)) / 0xFF,
            alpha: 1.0))
    }

    /// Color..init("0x0096E6")
    /// Color..init("#0096E6")
    /// Color..init("0096E6")
    init(_ hexColor: String) {
        var cString: String = hexColor.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        self.init(rgbValue)
    }
}
