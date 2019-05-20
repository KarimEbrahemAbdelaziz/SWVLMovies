//
//  MovieDetailsConfigurator.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/20/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation

protocol MovieDetailsConfigurator {
    func configure(movieDetailsViewController: MovieDetailsViewController)
}

class MovieDetailsConfiguratorImplementation: MovieDetailsConfigurator {
    
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func configure(movieDetailsViewController: MovieDetailsViewController) {
        
        let router = MovieDetailsViewRouterImplementation(movieDetailsViewController: movieDetailsViewController)
        let presenter = MovieDetailsPresenterImplementation(view: movieDetailsViewController,
                                                            movie: movie,
                                                            router: router)
        
        movieDetailsViewController.presenter = presenter
        
    }
}
