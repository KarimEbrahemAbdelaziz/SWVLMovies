//
//  MoviesConfigurator.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/19/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation

protocol MoviesConfigurator {
    func configure(moviesViewController: MoviesViewController)
}

class MoviesConfiguratorImplementation: MoviesConfigurator {
    
    func configure(moviesViewController: MoviesViewController) {
        
        let localMoviesGateway = LocalFileMoviesGateway(resourceName: "movies")
        let displayMoviesUseCase = DisplayMoviesUseCaseImplementation(moviesGateway: localMoviesGateway)
        let router = MoviesViewRouterImplementation(moviesViewController: moviesViewController)
        
        let presenter = MoviesPresenterImplementation(view: moviesViewController,
                                                      displayMoviesUseCase: displayMoviesUseCase,
                                                      router: router)
        
        moviesViewController.presenter = presenter
        
    }
}
