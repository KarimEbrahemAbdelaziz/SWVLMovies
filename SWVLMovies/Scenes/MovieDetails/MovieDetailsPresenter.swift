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
    func refreshMoviesView()
    func displayMovieRetrievalError(title: String, message: String)
}

protocol MovieDetailsPresenter {
    var movieTitle: String { get }
    var movieYear: String { get }
    var movieRate: Double { get }
    var movieImagesUrls: [URL] { get }
    var router: MovieDetailsViewRouter { get }
    
    func viewDidLoad()
    func dismissButtonPressed()
}

class MovieDetailsPresenterImplementation: MovieDetailsPresenter {
    
    fileprivate weak var view: MovieDetailsView?
    internal let router: MovieDetailsViewRouter
    fileprivate let movie: Movie
    fileprivate var movieImages: MovieImages!
    
    init(view: MovieDetailsView,
         movie: Movie,
         router: MovieDetailsViewRouter) {
        self.view = view
        self.movie = movie
        self.router = router
    }
    
    // MARK: - MovieDetailsPresenter
    
    var movieTitle: String {
        return movie.title
    }
    
    var movieYear: String {
        return  "Year: \(movie.year)"
    }
    
    var movieRate: Double {
        return Double(movie.rate)
    }
    
    var movieImagesUrls: [URL] {
        //swiftlint:disable all
        let urls = movieImages.images!.compactMap { photo -> URL? in
            guard let farm = movieImages.images?.last?.farm,
                let server = movieImages.images?.last?.server,
                let id = movieImages.images?.last?.id,
                let secret = movieImages.images?.last?.secret,
                let isPublic = movieImages.images?.last?.ispublic, isPublic == 1 else {
                    return nil
            }
            return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg")
        }
        return urls
        //swiftlint:enable all
    }
    
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
            case let .success(movieImages):
                self.handleMovieImagesReceived(movieImages)
            case let .failure(error):
               self.handleMovieImageRetrivalError(error)
            }
        }
    }
    
    fileprivate func handleMovieImagesReceived(_ movieImages: MovieImages) {
        self.movieImages = movieImages
        self.view?.hideLoadingState()
        view?.refreshMoviesView()
    }
    
    fileprivate func handleMovieImageRetrivalError(_ error: Error) {
        self.view?.hideLoadingState()
        self.view?.displayMovieRetrievalError(title: "Error!", message: error.localizedDescription)
    }
    
}
