//
//  ProgressManager.swift
//  Sports
//
//  Created by Mohammed Skaik on 06/10/2024.
//

import SwiftUI

@Observable
class ProgressManager {
    var showProgress = false
    var value: Double?
}


struct ProgressKey: EnvironmentKey {
    static let defaultValue = ProgressManager()
}

extension EnvironmentValues {
    var progressKey: ProgressManager {
        get { self[ProgressKey.self] }
        set { self[ProgressKey.self] = newValue }
    }
}
