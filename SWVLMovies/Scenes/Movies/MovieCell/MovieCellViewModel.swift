//
//  MovieCellViewModel.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/19/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation

struct MovieCellViewModel {
    
    let title: String
    let year: String
    let rate: String
    
    init(title: String, year: Int, rate: Int) {
        self.title = "Title: \(title)"
        self.year = "Year: \(year)"
        self.rate = "Rate: \(rate)"
    }
    
}
