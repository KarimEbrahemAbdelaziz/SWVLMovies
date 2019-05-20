//
//  LocalMovie.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/19/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation
import ObjectMapper
import Realm
import RealmSwift

class LocalMovie: Object, Mappable {
    
    @objc dynamic var title: String = ""
    dynamic var year: RealmOptional<Int> = RealmOptional<Int>(0)
    dynamic var rate: RealmOptional<Int> = RealmOptional<Int>(0)
    var cast = List<String>()
    var genres = List<String>()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "title"
    }
    
    override static func indexedProperties() -> [String] {
        return ["title", "rate"]
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        year.value <- map["year"]
        rate.value <- map["rating"]
        cast <- (map["cast"], arrayToList())
        genres <- (map["genres"], arrayToList())
    }
    
}

extension LocalMovie {
    var movie: Movie {
        return Movie(title: title,
                     year: year.value ?? 0,
                     rate: rate.value ?? 0,
                     cast: castArray ?? [],
                     genres: genresArray ?? [])
    }
}
