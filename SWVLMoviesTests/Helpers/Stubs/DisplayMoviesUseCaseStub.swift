//
//  DisplayMoviesUseCaseStub.swift
//  SWVLMoviesTests
//
//  Created by Karim Ebrahem on 5/21/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

@testable import SWVLMovies
import Foundation

class DisplayMoviesUseCaseStub: DisplayMoviesUseCase {
    var resultToBeReturned: Result<[Movie], Error>!
    
    func displayMovies(completionHandler: @escaping DisplayMoviesUseCaseCompletionHandler) {completionHandler(resultToBeReturned)
        
    }
}
