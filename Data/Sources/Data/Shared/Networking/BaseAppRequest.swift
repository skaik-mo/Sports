//
//  BaseAppRequest.swift
//  Data
//
//  Created by Mohammed Skaik on 14/06/2026.
//


import Networking

open class BaseAppRequest: BaseRequest {
    private let sportDto: SportTypeDto

    init(sportDto: SportTypeDto) {
        self.sportDto = sportDto
    }

    override open var baseUrl: String {
        APIConstants.baseUrl
    }

    open override var endpoint: String {
        self.sportDto.path + "/"
    }

    open override var parameters: Parameters {
        ["APIkey": APIConstants.apiKey]
    }

    open override var headers: [String : String] {
        ["Content-Type": "application/json"]
    }
}
