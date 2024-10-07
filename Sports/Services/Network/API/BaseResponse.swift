//  Skaik_mo
//
//  BaseResponse.swift
//  Sports
//
//  Created by Mohammed Skaik on 05/10/2024.
//

import Foundation
import UIKit

class BaseResponse {
    var code: Int?
    var error: String?
    var success: Bool?
    var message: String?
    var dic: [String: Any]?
    var array: [[String: Any]]?

    convenience init?(dictionary: [String: Any]?) {
        guard let dictionary, !dictionary.isEmpty else {
            return nil
        }
        self.init(array: dictionary["result"] as? [[String: Any]])
        self.error = dictionary["error"] as? String
        self.message = self.array?.first?["msg"] as? String
        self.success = dictionary["success"] as? Bool
        self.code = dictionary["code"] as? Int
        self.dic = dictionary
    }

    init?(array: [[String: Any]]?) {
        guard let _array = array, !_array.isEmpty else { return nil }
        self.array = array
    }
}
