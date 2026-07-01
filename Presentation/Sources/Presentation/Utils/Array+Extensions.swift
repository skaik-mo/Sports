//
//  Array+Extensions.swift
//  Presentation
//
//  Created by Mohammed Skaik on 01/07/2026.
//

extension Array {
    func split() -> (left: [Element], right: [Element]) {
        guard !self.isEmpty else { return (left: [], right: []) }

        let half = self.count / 2

        let leftSplit = self.prefix(half)
        let rightSplit = self.suffix(self.count - half)

        return (left: Array(leftSplit), right: Array(rightSplit))
    }
}
