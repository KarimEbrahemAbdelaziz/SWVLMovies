//
//  NSError+Extensions.swift
//  SWVLMoviesTests
//
//  Created by Karim Ebrahem on 5/21/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation

extension NSError {
    static func createError(withMessage message: String) -> NSError {
        return NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
