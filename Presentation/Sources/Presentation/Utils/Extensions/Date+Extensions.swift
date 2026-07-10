//
//  File.swift
//  Presentation
//
//  Created by Mohammed Skaik on 10/07/2026.
//

import Foundation

extension Date {
    var ddMMyyyy: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: self)
    }

    var timeFormatted: String {
        self.formatted(
            .dateTime
                .hour(.twoDigits(amPM: .omitted))
                .minute()
        )
    }
}
