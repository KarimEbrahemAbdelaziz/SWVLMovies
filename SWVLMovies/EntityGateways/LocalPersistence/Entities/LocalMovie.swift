//
//  LocalMovie.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/19/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation
import ObjectMapper

class LocalMovie: Mappable {
    
    var title: String?
    var year: Int?
    var rate: Int?
    var cast: [String]?
    var genres: [String]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        year <- map["year"]
        rate <- map["rate"]
        cast <- map["cast"]
        genres <- map["genres"]
    }
    
}

extension LocalMovie {
    var movie: Movie {
        return Movie(title: title ?? "",
                     year: year ?? 0,
                     rate: rate ?? 0,
                     cast: cast ?? [],
                     genres: genres ?? [])
    }
}
