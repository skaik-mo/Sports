//
//  String+Extension.swift
//  Presentation
//
//  Created by Mohammed Skaik on 01/07/2026.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, bundle: .module, comment: "")
    }
}
