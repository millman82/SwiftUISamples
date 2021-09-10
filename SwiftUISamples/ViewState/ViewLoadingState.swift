//
//  ViewLoadingState.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 9/10/21.
//

import SwiftUI

struct ViewLoadingState<T: View>: ViewModifier {
    @Binding var viewState: ViewState
    
    let loadingView: T
    
    func body(content: Content) -> some View {
        if viewState == .loading {
            ZStack {
                content
                loadingView
            }
        } else {
            content
        }
    }
}

extension View {
    func viewLoadingState<T: View>(viewState: Binding<ViewState>, @ViewBuilder loadingView: @escaping () -> T) -> some View {
        self.modifier(ViewLoadingState(viewState: viewState, loadingView: loadingView()))
    }
}
