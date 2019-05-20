//
//  MoviesViewSpy.swift
//  SWVLMoviesTests
//
//  Created by Karim Ebrahem on 5/21/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

@testable import SWVLMovies
import Foundation

class MoviesViewSpy: MoviesView {
    
    var refreshMoviesViewCalled = false
    var displayMoviesRetrievalErrorTitle: String?
    var displayMoviesRetrievalErrorMessage: String?
    
    func refreshMoviesView() {
        refreshMoviesViewCalled = true
    }
    
    func displayMoviesRetrievalError(title: String, message: String) {
        displayMoviesRetrievalErrorTitle = title
        displayMoviesRetrievalErrorMessage = message
    }
    
}
