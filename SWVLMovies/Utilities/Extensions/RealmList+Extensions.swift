//
//  RealmList+Extensions.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/20/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

func arrayToList<T>() -> TransformOf<List<T>, [T]> {
    return TransformOf(
        fromJSON: { (value: [T]?) -> List<T> in
            let result = List<T>()
            if let value = value {
                result.append(objectsIn: value)
            }
            return result
    },
        toJSON: { (value: List<T>?) -> [T] in
            var results = [T]()
            if let value = value {
                results.append(contentsOf: Array(value))
            }
            return results
    })
}
