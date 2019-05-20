//
//  MovieCellViewSpy.swift
//  SWVLMoviesTests
//
//  Created by Karim Ebrahem on 5/21/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

@testable import SWVLMovies
import Foundation

class MovieCellViewSpy: MovieCellView {
    var displayedTitle = ""
    var displayedYear = ""
    var displayedRate = ""
    
    func configure(with viewModel: MovieCellViewModel) {
        displayedTitle = viewModel.title
        displayedYear = viewModel.year
        displayedRate = viewModel.rate
    }
}
