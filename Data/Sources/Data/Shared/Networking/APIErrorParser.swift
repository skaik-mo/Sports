//
//  APIErrorParser.swift
//  Data
//
//  Created by Mohammed Skaik on 14/06/2026.
//


import Foundation
import Networking

public final class APIErrorParser: APIErrorParserProtocol {

    private let decoder = JSONDecoder()

    public init(){}

    public func parse(_ data: Data) -> NetworkError? {
        guard let errorDto = try? decoder.decode(APIErrorDto.self, from: data),
            errorDto.error == "1",
            let firstResult = errorDto.result.first
        else { return nil }

        var message = firstResult.msg ?? "Something went wrong"
        if let param = firstResult.param {
            message += " [\(param)]"
        }

        return .apiError(
            message: message,
            code: firstResult.cod
        )
    }
}
