//
//  MoviesGateway.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/19/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation

typealias FetchMoviesEntityGatewayCompletionHandler = (_ movies: Result<[Movie], Error>) -> Void

protocol MoviesGateway {
    func fetchMovies(completionHandler: @escaping FetchMoviesEntityGatewayCompletionHandler)
}
