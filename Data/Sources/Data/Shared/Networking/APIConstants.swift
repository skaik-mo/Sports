//
//  APIConstants.swift
//  Data
//
//  Created by Mohammed Skaik on 14/06/2026.
//


import Foundation

enum APIConstants {
    static let baseUrl = "https://apiv2.allsportsapi.com/"

    static var apiKey: String {
        value(for: "SPORTS_API_KEY")
    }

    private static func value(for key: String) -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String, !value.isEmpty
        else {
            fatalError("⚠️ Missing \(key) — check Secrets.xcconfig")
        }
        return value
    }
}
