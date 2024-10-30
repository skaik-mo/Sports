//  Skaik_mo
//
//  ResponseHandler.swift
//  Sports
//
//  Created by Mohammed Skaik on 05/10/2024.
//

import Foundation

enum BaseResult {
    case success(response: Dictionary<String, Any>)
    case failure(error: Error, response: Dictionary<String, Any>)
}

class ResponseHandler {
    class func responseHandler(result: BaseResult, isShowMessage: Bool = true, alertManager: AlertManager?) {
        switch result {
        case .success(response: _):
            break
        case .failure(error: let error, response: _):
            alertManager?.showAlert = isShowMessage
            alertManager?.title = "Oops! Something went wrong..."
            alertManager?.message = error.localizedDescription
            break
        }
    }
    
    class func checkResponseValidity(_ response: BaseResponse?) -> Bool {
        if let _response = response {
            return _response.success == true
        }
        return false
    }
    
}
