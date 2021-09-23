//
//  ViewAlertState.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 9/10/21.
//

import SwiftUI

struct ViewAlertState: ViewModifier {
    @Binding var viewState: ViewState
    var updatedAction: (() -> Void)?
    
    func body(content: Content) -> some View {
        return content
            .alert(isPresented: .constant(viewState.isAlertState), content: {
                var alertTitle: String?
                var alertMessage: String?
                
                switch viewState {
                case let .error(title, message):
                    alertTitle = title
                    alertMessage = message
                case let .updated(title, message):
                    alertTitle = title
                    alertMessage = message
                default:
                    alertTitle = nil
                    alertMessage = nil
                }
                
                var message: Text?
                
                if let alertMessage = alertMessage {
                    message = Text(alertMessage)
                }
                
                return Alert(title: Text(alertTitle ?? ""), message: message, dismissButton: .default(Text("OK")) {
                    if viewState.isUpdated {
                        updatedAction?()
                    }
                    
                    viewState = .idle
                })
            })
    }
}

extension View {
    func viewAlertState(viewState: Binding<ViewState>, updatedAction: (() -> Void)? = nil) -> some View {
        self.modifier(ViewAlertState(viewState: viewState, updatedAction: updatedAction))
    }
}
