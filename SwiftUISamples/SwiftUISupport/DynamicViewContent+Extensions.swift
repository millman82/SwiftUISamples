//
//  DynamicViewContent+Extensions.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 9/21/21.
//

import SwiftUI

extension DynamicViewContent {
    // Conditional onDelete Action
    @inlinable func onDelete(condition: Bool, perform action: ((IndexSet) -> Void)?) -> some DynamicViewContent {
        if condition {
            return self.onDelete(perform: action)
        }
        
        return self.onDelete(perform: nil)
    }
}
