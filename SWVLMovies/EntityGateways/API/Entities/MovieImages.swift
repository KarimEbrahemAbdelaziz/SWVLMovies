//
//  MovieImages.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/20/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieImages: Mappable {
    
    var images: [Photo]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        images <- map["photos.photo"]
    }
    
}

class Photo: Mappable {
    
    var id: String?
    var owner: String?
    var secret: String?
    var server: String?
    var farm: Int?
    var title: String?
    var ispublic: Int?
    var isfriend: Int?
    var isfamily: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        owner <- map["owner"]
        secret <- map["secret"]
        server <- map["server"]
        farm <- map["farm"]
        title <- map["title"]
        ispublic <- map["ispublic"]
        isfriend <- map["isfriend"]
        isfamily <- map["isfamily"]
    }
    
}
