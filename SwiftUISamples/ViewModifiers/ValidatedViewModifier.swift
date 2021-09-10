//
//  ValidatedViewModifier.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 9/3/21.
//

import SwiftUI

struct ValidatedViewModifier: ViewModifier {
    let isValid: Bool
    let validationMessage: String
    
    func body(content: Content) -> some View {
        if !isValid {
            VStack(alignment: .leading) {
                content
                Text(validationMessage)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        } else {
            content
        }
    }
}

extension View {
    func validated(isValid: @escaping () -> Bool, validationMessage: String) -> some View {
        self.modifier(ValidatedViewModifier(isValid: isValid(), validationMessage: validationMessage))
    }
}
