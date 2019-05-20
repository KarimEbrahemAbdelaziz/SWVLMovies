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
    var movieCast: String { get }
    var movieGenres: String { get }
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
        return "Year: \(movie.year)"
    }
    
    var movieRate: Double {
        return Double(movie.rate)
    }
    
    var movieCast: String {
        guard !movie.cast.isEmpty else {
            return ""
        }
        
        var castString = "Cast: "
        movie.cast.forEach { cast in
            castString.append("\(cast)")
            if cast != movie.cast.last! {
                castString.append(", ")
            }
        }
        return castString
    }
    
    var movieGenres: String {
        guard !movie.genres.isEmpty else {
            return ""
        }
        
        var genresString = "Genres: "
        movie.genres.forEach { genre in
            genresString.append("\(genre)")
            if genre != movie.genres.last! {
                genresString.append(", ")
            }
        }
        return genresString
    }
    
    var movieImagesUrls: [URL] {
        //swiftlint:disable all
        guard movieImages != nil else {
            return []
        }
        
        let urls = movieImages.images!.compactMap { photo -> URL? in
            guard let farm = photo.farm,
                let server = photo.server,
                let id = photo.id,
                let secret = photo.secret,
                let isPublic = photo.ispublic, isPublic == 1 else {
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
    
    fileprivate func handleMovieImageRetrivalError(_ error: MovieManager.MovieManagerError) {
        switch error {
        case .networkError:
            self.view?.displayMovieRetrievalError(title: "Error!", message: "Please check your internet connection and try again later.")
        case .parseFailed:
            self.view?.displayMovieRetrievalError(title: "Error!", message: "Failed to load data, please try again.")
        }
    }
    
}
