//
//  MovieManager.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/20/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Alamofire
import Foundation

class MovieManager {
    
    enum MovieManagerError: Error {
        case parseFailed
        case networkError
    }

    static func fetchMovieImages(movieTitle: String, _ completionHandler: @escaping (Result<MovieImages, Error>) -> Void) {
        let request = MovieRouter.fetchMovieImages(movieName: movieTitle)
        AF.request(request).responseJSON { response in
            switch response.result {
            case let .success(value):
                guard let jsonObject = value as? [String: Any], let movieImages = MovieImages(JSON: jsonObject) else {
                    completionHandler(.failure(MovieManagerError.parseFailed))
                    return
                }
                completionHandler(.success(movieImages))
            case .failure:
                completionHandler(.failure(MovieManagerError.networkError))
            }
        }
    }
    
}
