//
//  ViewState.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 9/10/21.
//

import Foundation

enum ViewState: Equatable {
    case idle
    case loading
    case updated(messageTitle: String, message: String)
    case error(errorTitle: String, errorMessage: String)
    
    var isError: Bool {
        if case .error(_, _) = self {
            return true
        }
        
        return false
    }
    
    var isAlertState: Bool {
        switch self {
        case .error, .updated:
            return true
        default:
            return false
        }
    }
}
