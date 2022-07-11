//
//  AppEnvironmentKey.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 7/6/22.
//

import SwiftUI

struct AppEnvironmentKey: EnvironmentKey {
    #if DEBUG
    static let defaultValue: AppEnvironment = .dev
    #else
    static let defaultValue: AppEnvironment = .prod
    #endif
}

extension EnvironmentValues {
    var appEnvironment: AppEnvironment {
        get { self[AppEnvironmentKey.self] }
        set { self[AppEnvironmentKey.self] = newValue }
    }
}
