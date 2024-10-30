//
//  MockNetworkService.swift
//  Sports
//
//  Created by Mohammed Skaik on 29/10/2024.
//

import XCTest
@testable import Sports

class MockNetworkService: NetworkService {

    var capturedRequest: BaseRequest?
    var capturedSuccessHandler: (([String: Any], Int, String) -> Void)?
    var capturedFailureHandler: (([String: Any], Int, Error) -> Void)?
    var shouldFailRequest = false
    var response: [String: Any]?
    var responseCode = 200

    func requestWithSuccessResponse(with request: BaseRequest, isShowLoader: Bool, isShowMessage: Bool, success: successHandler) -> NetworkService {
        capturedRequest = request
        capturedSuccessHandler = success

        if shouldFailRequest {
            let error = NSError(domain: "Mock Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock request failed"])
            capturedFailureHandler?([:], responseCode, error)
        } else {
            capturedSuccessHandler?(response ?? [:], responseCode, "Mock response message")
        }

        return self
    }
}
