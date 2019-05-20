//
//  MovieDetailsPresenter.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/20/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation

protocol MovieDetailsView: AnyObject {
    func setupUI()
    func showLoadingState()
    func hideLoadingState()
    func displayMovieRetrievalError(title: String, message: String)
}

protocol MovieDetailsPresenter {
    var router: MovieDetailsViewRouter { get }
    
    func viewDidLoad()
    func dismissButtonPressed()
}

class MovieDetailsPresenterImplementation: MovieDetailsPresenter {
    
    fileprivate weak var view: MovieDetailsView?
    internal let router: MovieDetailsViewRouter
    fileprivate let movie: Movie
    
    init(view: MovieDetailsView,
         movie: Movie,
         router: MovieDetailsViewRouter) {
        self.view = view
        self.movie = movie
        self.router = router
    }
    
    // MARK: - MovieDetailsPresenter
    
    func viewDidLoad() {
        view?.setupUI()
        view?.showLoadingState()
        
        loadMovieImages()
    }
    
    func dismissButtonPressed() {
        router.dismissView()
    }
    
    // MARK: - Private Funcitons
    
    fileprivate func loadMovieImages() {
        MovieManager.fetchMovieImages(movieTitle: movie.title) { result in
            switch result {
            case let .success(jsonObject):
                self.view?.hideLoadingState()
                print(jsonObject)
            case let .failure(error):
                self.view?.hideLoadingState()
                self.view?.displayMovieRetrievalError(title: "Error!", message: error.localizedDescription)
            }
        }
    }
    
}
