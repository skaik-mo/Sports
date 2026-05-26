//
//  String.swift
//  Sports
//
//  Created by Mohammed Skaik on 10/10/2024.
//


import Foundation

extension String {

    var toDate: Date? {
        self._dateWithFormate(dataFormat: GlobalConstants.dateAndTimeFormat)
    }

    func _dateWithFormate(dataFormat: String, timeZone: String = TimeZone.current.identifier) -> Date? {
        let formatter = DateFormatter()
        formatter.calendar = Calendar.init(identifier: .gregorian)
        formatter.dateFormat = dataFormat
        formatter.timeZone = TimeZone.init(identifier: timeZone)
        return formatter.date(from: self)
    }
}
