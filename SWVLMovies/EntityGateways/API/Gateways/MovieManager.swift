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

    static func fetchMovieImages(movieTitle: String, _ completionHandler: @escaping (Result<[String: Any], Error>) -> Void) {
        let request = MovieRouter.fetchMovieImages(movieName: movieTitle)
        AF.request(request).responseJSON { response in
            switch response.result {
            case let .success(value):
                let jsonObject = value as! [String: Any]
                completionHandler(.success(jsonObject))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
