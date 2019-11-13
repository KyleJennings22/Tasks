//
//  DateHelpers.swift
//  Tasks
//
//  Created by Kyle Jennings on 11/13/19.
//  Copyright © 2019 Kyle Jennings. All rights reserved.
//

import Foundation

extension Date {
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}

