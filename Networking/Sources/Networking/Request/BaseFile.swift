//
//  BaseFile.swift
//  Networking
//
//  Created by Mohammed Skaik on 14/06/2026.
//

import Foundation

public struct BaseFile {
    public let data: Data
    public let name: String
    public let fileName: String
    public let mimeType: String

    public init(data: Data, name: String, fileName: String, mimeType: String) {
        self.data = data
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }
}
