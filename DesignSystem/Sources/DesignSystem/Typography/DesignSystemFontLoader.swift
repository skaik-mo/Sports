//
//  DesignSystemFontLoader.swift
//  DesignSystem
//
//  Created by Mohammed Skaik on 25/07/2026.
//


import SwiftUI
import CoreText

public final class DesignSystemFontLoader {
    public static func registerFonts() {
        let bundle = Bundle.module
        let fontNames = ["Poppins-Regular", "Poppins-Medium", "Poppins-Bold"]
        
        for fontName in fontNames {
            guard let url = bundle.url(
                forResource: fontName,
                withExtension: "ttf"
            ),
                  let fontDataProvider = CGDataProvider(url: url as CFURL),
                  let font = CGFont(fontDataProvider) else {
                print("❌ Failed to load font file: \(fontName)")
                continue
            }
            
            var error: Unmanaged<CFError>?
            if CTFontManagerRegisterGraphicsFont(font, &error) {
                print("✅ Successfully registered font: \(fontName)")
            } else {
                print("⚠️ Font already registered or failed: \(fontName)")
            }
        }
    }
}
