//
//  AlertManager.swift
//  Sports
//
//  Created by Mohammed Skaik on 06/10/2024.
//

import SwiftUI

@Observable
class AlertManager {
    var showAlert = false
    var title: String = ""
    var message: String = ""

}


struct AlertKey: EnvironmentKey {
    static let defaultValue = AlertManager()
}

extension EnvironmentValues {
    var alertKey: AlertManager {
        get { self[AlertKey.self] }
        set { self[AlertKey.self] = newValue }
    }
}
