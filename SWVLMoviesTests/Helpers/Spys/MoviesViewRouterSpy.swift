//
//  MoviesViewRouterSpy.swift
//  SWVLMoviesTests
//
//  Created by Karim Ebrahem on 5/21/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

@testable import SWVLMovies
import Foundation

class MoviesViewRouterSpy: MoviesViewRouter {
    
    var passedMovie: Movie!
    
    func presentDetailsView(for movie: Movie) {
        passedMovie = movie
    }
    
}
