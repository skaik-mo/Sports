//
//  EventBaseAppRequest.swift
//  Data
//
//  Created by Mohammed Skaik on 27/06/2026.
//

import Networking
import Foundation
import Domain

struct EventBaseAppRequest: BaseAppRequest {
    let sportType: SportType
    let extraParams: Parameters
    var method: HTTPMethod { .get }
    var parameters: Parameters {
        var params = baseParameters
        params["met"] = "Fixtures"
        params["timezone"] = TimeZone.current.identifier
        params.merge(extraParams) { _, newValue in newValue }
        return params
    }
}
