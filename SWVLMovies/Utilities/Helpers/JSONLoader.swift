//
//  JSONLoader.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/19/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation

class JSONLoader {
    enum JSONLoaderError: Error {
        case dataLoadingFailed
        case jsonSerializationFailed
        case castingJsonToDictionaryFailed
        case pathNotFound
    }
    
    static func loadJSON(from resourceName: String) -> Result<[String: Any], JSONLoaderError> {
        if let path = Bundle.main.path(forResource: resourceName, ofType: "json") {
            guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
                return .failure(.dataLoadingFailed)
            }
            
            guard let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) else {
                return .failure(.jsonSerializationFailed)
            }
            
            guard let jsonDictionary = jsonResult as? [String: Any] else {
                return .failure(.castingJsonToDictionaryFailed)
            }
            
            return .success(jsonDictionary)
        } else {
            return .failure(.pathNotFound)
        }
    }
}
