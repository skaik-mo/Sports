//
//  OrEmpty.swift
//  Data
//
//  Created by Mohammed Skaik on 14/06/2026.
//


extension String? {
    func orEmpty() -> String {
        guard let self else { return "" }
        return self
    }
}
