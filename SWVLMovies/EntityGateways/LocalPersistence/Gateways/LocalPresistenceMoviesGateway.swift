//
//  LocalPresistenceMoviesGateway.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/19/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation
import ObjectMapper

protocol LocalPersistenceMoviesGateway: MoviesGateway { }

class LocalFileMoviesGateway: LocalPersistenceMoviesGateway {
    
    // MARK: - Properties
    private var resourceName: String
    
    enum LocalFileMoviesError: Error {
        case parseFailed
    }
    
    // MARK: - Init
    
    init(resourceName: String) {
        self.resourceName = resourceName
    }
    
    // MARK: - MoviesGateway
    
    func fetchMovies(completionHandler: @escaping FetchMoviesEntityGatewayCompletionHandler) {
        let result = JSONLoader.loadJSON(from: resourceName)
        switch result {
        case let .success(jsonMovies):
            guard let localMovies = convertJsonToLocalMovies(json: jsonMovies) else {
                completionHandler(.failure(LocalFileMoviesError.parseFailed))
                return
            }
            
            let movies = localMovies.map { $0.movie }
            completionHandler(.success(movies))
        case let .failure(error):
            completionHandler(.failure(error))
        }
    }
    
    // MARK: - Private Functions
    
    private func convertJsonToLocalMovies(json: [String: Any]) -> [LocalMovie]? {
        let movies: [LocalMovie]? = Mapper<LocalMovie>().mapArray(JSONObject: json["movies"]) ?? nil
        return movies
    }
    
}
