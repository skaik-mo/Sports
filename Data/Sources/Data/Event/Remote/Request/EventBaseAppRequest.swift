//
//  EventBaseAppRequest.swift
//  Data
//
//  Created by Mohammed Skaik on 27/06/2026.
//

import Networking
import Foundation

class EventBaseAppRequest: BaseAppRequest {
    private var extraParams: Parameters

    override var method: HTTPMethod { .get }

    override var parameters: Parameters {
        var params = super.parameters
        params["met"] = "Fixtures"
        params["timezone"] = TimeZone.current.identifier
        params.merge(extraParams) { _, newValue in newValue }
        return params
    }

    init(sportDto: SportTypeDto, extraParams: Parameters) {
        self.extraParams = extraParams
        super.init(sportDto: sportDto)
    }

}
