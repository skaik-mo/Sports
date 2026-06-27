//
//  DateFormatter.swift
//  Data
//
//  Created by Mohammed Skaik on 27/06/2026.
//

import Foundation

extension DateFormatter {
    static func dateFormat(format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = .current
        return formatter
    }
}
