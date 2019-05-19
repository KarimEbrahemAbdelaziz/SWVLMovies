//
//  DisplayMoviesList.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/19/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation

typealias DisplayMoviesUseCaseCompletionHandler = (_ movies: Result<[Movie], Error>) -> Void

protocol DisplayMoviesUseCase {
    func displayMovies(completionHandler: @escaping DisplayMoviesUseCaseCompletionHandler)
}

class DisplayMoviesUseCaseImplementation: DisplayMoviesUseCase {
    let moviesGateway: MoviesGateway
    
    init(moviesGateway: MoviesGateway) {
        self.moviesGateway = moviesGateway
    }
    
    // MARK: - DisplayMoviesUseCase
    
    func displayMovies(completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        self.moviesGateway.fetchMovies { (result) in
            // Do any additional processing & after that call the completion handler
            completionHandler(result)
        }
    }
}
