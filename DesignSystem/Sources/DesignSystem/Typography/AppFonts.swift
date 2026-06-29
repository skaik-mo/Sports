//
//  AppFonts.swift
//  DesignSystem
//
//  Created by Mohammed Skaik on 29/06/2026.
//

import SwiftUI

public enum AppFonts {

    // MARK: - Font Names
    enum FontName {
        static let regular = "Poppins-Regular"
        static let medium = "Poppins-Medium"
        static let bold = "Poppins-Bold"
    }

    // MARK: - Regular
    public static let regular16: Font = .custom(FontName.regular, size: 16)
    public static let regular14: Font = .custom(FontName.regular, size: 14)

    // MARK: - Medium
    public static let medium26: Font = .custom(FontName.medium, size: 26)
    public static let medium20: Font = .custom(FontName.medium, size: 20)
    public static let medium16: Font = .custom(FontName.medium, size: 16)
    public static let medium14: Font = .custom(FontName.medium, size: 14)

    // MARK: - Bold
    public static let bold24: Font = .custom(FontName.bold, size: 24)
    public static let bold16: Font = .custom(FontName.bold, size: 16)
}
