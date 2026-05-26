//  Skaik_mo
//
//  BaseRequest.swift
//  Sports
//
//  Created by Mohammed Skaik on 05/10/2024.
//

import Foundation
import Alamofire

class BaseRequest {

    var base_url: String {
        return APIConstants.BaseUrl.rawValue
    }

    var end_point: String = ""

    var method: HTTPMethod = .get

    var parameters: [String: Any] = [:]

    var files: [BaseFile] = []
}

class BaseFile {
    var name: String?
    var key_name: String?
    var mime_type: String?
    var data: Data?
}
