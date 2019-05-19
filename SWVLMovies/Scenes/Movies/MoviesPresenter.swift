//
//  MoviesPresenter.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/19/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation

protocol MoviesView: AnyObject {
    func refreshMoviesView()
    func displayMoviesRetrievalError(title: String, message: String)
}

protocol MovieCellView {
    func configure(with viewModel: MovieCellViewModel)
}

protocol MoviesPresenter {
    var numberOfMovies: Int { get }
    var router: MoviesViewRouter { get }
    
    func viewDidLoad()
    func configure(cell: MovieCellView, forRow row: Int)
    func didSelect(row: Int)
    func searchAbout(movieTitle: String)
}

class MoviesPresenterImplementation: MoviesPresenter {
    fileprivate weak var view: MoviesView?
    fileprivate let displayMoviesUseCase: DisplayMoviesUseCase
    internal let router: MoviesViewRouter
    
    // Normally this would be file private as well, we keep it internal so we can inject values for testing purposes
    private var movies = [Movie]()
    var searchResultMovies = [Movie]()
    
    var numberOfMovies: Int {
        return searchResultMovies.count
    }
    
    init(view: MoviesView,
         displayMoviesUseCase: DisplayMoviesUseCase,
         router: MoviesViewRouter) {
        self.view = view
        self.displayMoviesUseCase = displayMoviesUseCase
        self.router = router
    }
    
    // MARK: - MoviesPresenter
    
    func viewDidLoad() {
        self.displayMoviesUseCase.displayMovies { (result: Result<[Movie], Error>) in
            switch result {
            case let .success(movies):
                self.handleMoviesReceived(movies)
            case let .failure(error):
                self.handleMoviesError(error)
            }
        }
    }
    
    func configure(cell: MovieCellView, forRow row: Int) {
        let movie = searchResultMovies[row]
        let viewModel = MovieCellViewModel(title: movie.title, year: movie.year, rate: movie.rate)
        
        cell.configure(with: viewModel)
    }
    
    func didSelect(row: Int) {
        let movie = searchResultMovies[row]
        
        router.presentDetailsView(for: movie)
    }
    
    func searchAbout(movieTitle: String) {
        guard !movieTitle.isEmpty else {
            self.searchResultMovies = movies
            view?.refreshMoviesView()
            return
        }
        
        self.searchResultMovies = movies.filter { movie -> Bool in
            return movie.title.contains(movieTitle)
        }
        view?.refreshMoviesView()
    }
    
    // MARK: - Private Funcitons
    
    fileprivate func handleMoviesReceived(_ movies: [Movie]) {
        self.movies = movies
        self.searchResultMovies = movies
        view?.refreshMoviesView()
    }
    
    fileprivate func handleMoviesError(_ error: Error) {
        view?.displayMoviesRetrievalError(title: "Error", message: error.localizedDescription)
    }
    
}
