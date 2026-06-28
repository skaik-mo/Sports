//
//  TeamBaseAppRequest.swift
//  Data
//
//  Created by Mohammed Skaik on 27/06/2026.
//

import Networking
import Domain

class TeamBaseAppRequest: BaseAppRequest {
    private var params: Parameters = [:]

    override var method: HTTPMethod { .get }

    override var parameters: Parameters {
        params["met"] = "Teams"
        return params
    }

    init(sportType: SportType, leagueId: Int) {
        super.init(sportType: sportType)
        self.params = super.parameters
        params["leagueId"] = leagueId
    }
}
