//
//  DisplayMoviesListTest.swift
//  SWVLMoviesTests
//
//  Created by Karim Ebrahem on 5/21/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

@testable import SWVLMovies
import XCTest

class DisplayMoviesListTest: XCTestCase {
    
    let moviesGatewaySpy = MoviesGatewaySpy()
    var displayMoviesListUseCase: DisplayMoviesUseCaseImplementation!
    
    // MARK: - Set up
    
    override func setUp() {
        super.setUp()
        
        displayMoviesListUseCase = DisplayMoviesUseCaseImplementation(moviesGateway: moviesGatewaySpy)
    }
    
    // MARK: - Tests
    
    func test_fetch_success_calls_completion_handler() {
        // Given
        let expectedResultToBeReturned: Result<[Movie], Error> = Result.success([])
        moviesGatewaySpy.fetchMoviesResultToBeReturned = expectedResultToBeReturned
        
        let fetchMoviesCompletionHandlerExpectation = expectation(description: "Fetch Movies Expectation")
        
        // When
        displayMoviesListUseCase.displayMovies { result in
            // Then
            switch result {
            case .success(let value):
                let successValue = try! expectedResultToBeReturned.get()
                XCTAssertEqual(successValue.count, value.count, "Completion handler didn't return the expected result")
            case .failure:
                break
            }
            fetchMoviesCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_fetch_failuer_calls_completion_handler() {
        // Given
        let expectedResultToBeReturned: Result<[Movie], Error> = Result.failure(MovieManager.MovieManagerError.networkError)
        moviesGatewaySpy.fetchMoviesResultToBeReturned = expectedResultToBeReturned
        
        let fetchMoviesCompletionHandlerExpectation = expectation(description: "Fetch Movies Expectation")
        
        // When
        displayMoviesListUseCase.displayMovies { result in
            // Then
            switch result {
            case .success:
                break
            case .failure(let error):
                XCTAssertNotNil(error, "Completion handler didn't get called")
            }
            fetchMoviesCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}
