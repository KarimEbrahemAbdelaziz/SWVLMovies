//
//  MoviesGatewaySpy.swift
//  SWVLMoviesTests
//
//  Created by Karim Ebrahem on 5/21/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

@testable import SWVLMovies
import Foundation

class MoviesGatewaySpy: MoviesGateway {
    var fetchMoviesResultToBeReturned: Result<[Movie], Error>!
    
    func fetchMovies(completionHandler: @escaping FetchMoviesEntityGatewayCompletionHandler) {
        completionHandler(fetchMoviesResultToBeReturned)
    }
}
