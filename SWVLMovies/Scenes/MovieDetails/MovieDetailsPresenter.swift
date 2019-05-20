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
    
    func viewDidLoad() {
        view?.setupUI()
        view?.showLoadingState()
    }
    
    func dismissButtonPressed() {
        router.dismissView()
    }
    
}
