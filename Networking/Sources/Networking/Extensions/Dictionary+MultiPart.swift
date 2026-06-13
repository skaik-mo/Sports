//
//  Dictionary+MultiPart.swift
//  Networking
//
//  Created by Mohammed Skaik on 14/06/2026.
//

import Alamofire

extension Dictionary {
    func getMultiPart(multiPart: MultipartFormData, key: String? = nil) {
        for (dicKey, value) in self {
            var keY: String = (dicKey as? String) ?? ""
            if let key = key, key.count > 0 {
                keY = "\(key)[\(keY)]" //// address[tags][0][id]
            }
            else if let temp = value as? String, let data = temp.data(using: .utf8) {
                multiPart.append(data, withName: keY)
            }
            else if let temp = value as? Int, let data = "\(temp)".data(using: .utf8) {
                multiPart.append(data, withName: keY)
            }
            else if let temp = value as? Float, let data = "\(temp)".data(using: .utf8) {
                multiPart.append(data, withName: keY)
            }
            else if let temp = value as? Double, let data = "\(temp)".data(using: .utf8) {
                multiPart.append(data, withName: keY)
            }
            else if let temp = value as? Bool, let data = "\(temp)".data(using: .utf8) {
                multiPart.append(data, withName: keY)
            }
            else if let item = value as? Dictionary { // address
                item.getMultiPart(multiPart: multiPart, key: keY)
            }
            else if let temp = value as? [Dictionary] {
                for (index, item) in temp.enumerated() {
                    item.getMultiPart(multiPart: multiPart, key: keY + "[\(index)]")
                }
            }
        }
    }
}
