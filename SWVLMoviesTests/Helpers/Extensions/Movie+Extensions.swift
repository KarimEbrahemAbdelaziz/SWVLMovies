//
//  Movie+Extensions.swift
//  SWVLMoviesTests
//
//  Created by Karim Ebrahem on 5/21/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

@testable import SWVLMovies
import Foundation

extension Movie {
    static func createMoviesArray(numberOfElements: Int = 2) -> [Movie] {
        var movies = [Movie]()
        
        for identifire in 0..<numberOfElements {
            let movie = createMovie(index: identifire)
            movies.append(movie)
        }
        
        return movies
    }
    
    static func createMovie(index: Int = 0) -> Movie {
        return Movie(title: "\(index)", year: index, rate: index, cast: [], genres: [])
    }
    
    
}

extension Movie: Equatable { }

public func == (lhs: Movie, rhs: Movie) -> Bool {
    return lhs.title == rhs.title
}
