//
//  DependentEnvironmentKey.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 7/6/22.
//

import Foundation
import SwiftUI

protocol Logger {
    func log()
    func log(message: String)
}

class LoggerImpl: Logger {
    private let appEnvironment: AppEnvironment

    init(appEnvironment: AppEnvironment) {
        print("Initializing: \(String(describing: Logger.self))")
        self.appEnvironment = appEnvironment
    }

    func log() {
        print("Selected environment: \(appEnvironment.rawValue)")
    }

    func log(message: String) {
        print(message)
    }
}

struct LoggerEnvironmentKey: EnvironmentKey {
    static let defaultValue: Logger = LoggerImpl(appEnvironment: Environment(\.appEnvironment).wrappedValue)
}

extension EnvironmentValues {
    var logger: Logger {
        get { self[LoggerEnvironmentKey.self] }
        set { self[LoggerEnvironmentKey.self] = newValue }
    }
}

protocol SampleService {
    func doSomething()
}

class SampleServiceImpl: SampleService {
    private let logger: Logger

    init(logger: Logger) {
        self.logger = logger
    }

    func doSomething() {
        logger.log(message: "Did a thing!")
    }
}

struct SampleServiceKey: EnvironmentKey {
    static let defaultValue: SampleService = SampleServiceImpl(logger: Environment(\.logger).wrappedValue)
}

extension EnvironmentValues {
    var sampleService: SampleService {
        get { self[SampleServiceKey.self] }
        set { self[SampleServiceKey.self] = newValue }
    }
}
