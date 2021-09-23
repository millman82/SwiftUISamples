//
//  NavigationModalPresentation.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 9/23/21.
//

import SwiftUI

private struct NavigationModalPresentationKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    var navigationModalPresented: Binding<Bool> {
        get { self[NavigationModalPresentationKey.self] }
        set { self[NavigationModalPresentationKey.self] = newValue }
    }
}
