//
//  TeamBaseAppRequest.swift
//  Data
//
//  Created by Mohammed Skaik on 27/06/2026.
//

import Networking

class TeamBaseAppRequest: BaseAppRequest {
    private var params: Parameters = [:]

    override var method: HTTPMethod { .get }

    override var parameters: Parameters {
        params["met"] = "Teams"
        return params
    }

    init(sportDto: SportTypeDto, leagueId: Int) {
        super.init(sportDto: sportDto)
        self.params = super.parameters
        params["leagueId"] = leagueId
    }
}
