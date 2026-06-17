//
//  APIErrorParserProtocol.swift
//  Networking
//
//  Created by Mohammed Skaik on 14/06/2026.
//

import Foundation

public protocol APIErrorParserProtocol {
    func parse(_ data: Data) -> NetworkError?
}
