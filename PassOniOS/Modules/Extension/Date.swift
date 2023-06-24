//
//  Date.swift
//  PassOniOS
//
//  Created by niv ben-porath on 24/06/2023.
//

import Foundation

extension Date {
    func isoFormat() -> String {
        let formatter = ISO8601DateFormatter()
        let isoDateString = formatter.string(from: self)
        return isoDateString
    }
}
