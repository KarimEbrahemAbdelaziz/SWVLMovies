//
//  MovieRealmManager.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/20/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class MovieRealmManager {
    
    private static let realm = try! Realm(configuration: RealmConfig.main.configuration)
    
    static func restoreObjects() -> Results<LocalMovie> {
        let objects = realm.objects(LocalMovie.self)
        return objects
    }
    
    static func save(objects: [LocalMovie]) {
        try? realm.write {
            realm.add(objects, update: true)
        }
    }
    
    static func filter(by searchTerm: String) -> Results<LocalMovie> {
        let objects = realm.objects(LocalMovie.self)
            .filter("title contains %@", searchTerm)
            .sorted(byKeyPath: "rate", ascending: false)
        return objects
    }
    
    static func deleteAll() {
        try? realm.write {
            realm.deleteAll()
        }
    }
    
}
