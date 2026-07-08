//
//  String+OrEmpty.swift
//  Presentation
//
//  Created by Mohammed Skaik on 08/07/2026.
//


extension String? {
    func orEmpty() -> String {
        guard let self else { return "" }
        return self
    }
}
