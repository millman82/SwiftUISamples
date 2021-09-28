//
//  String+Extensions.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 9/28/21.
//

import Foundation

extension String {
    @available(iOS, introduced: 8, obsoleted: 15)
    func localized(with comment: String = "") -> String {
        NSLocalizedString(self, comment: comment)
    }
}
