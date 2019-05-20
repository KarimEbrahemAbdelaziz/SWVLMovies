//
//  MovieRouter.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/20/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

//swiftlint:disable all
import Alamofire
import Keys
import Foundation

enum MovieRouter: URLRequestConvertible {
    static let cocoaPodsKeys = SWVLMoviesKeys()
    
    static let baseURLString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(cocoaPodsKeys.flickrAPIKeyDevelopment)&format=json&nojsoncallback=1"
    
    case fetchMovieImages(movieName: String)
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .fetchMovieImages:
                return .get
            }
        }
        
        let params: ([String: Any]?) = {
            switch self {
            case .fetchMovieImages:
                return nil
            }
        }()
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self {
            case let .fetchMovieImages(movieTitle):
                relativePath = movieTitle
            }
            
            var url: URL!
            if let relativePath = relativePath {
                switch self {
                case .fetchMovieImages:
                    
                    let queryItems = [URLQueryItem(name: "text", value: relativePath)]
                    var urlComps = URLComponents(string: MovieRouter.baseURLString)!
                    urlComps.queryItems = queryItems
                    url = try! urlComps.asURL()
                    url = url.appending("method", value: "flickr.photos.search")
                    url = url.appending("api_key", value: MovieRouter.cocoaPodsKeys.flickrAPIKeyDevelopment)
                    url = url.appending("format", value: "json")
                    url = url.appending("nojsoncallback", value: "1")
                }
            }
            return url
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let encoding: ParameterEncoding = {
            return JSONEncoding.default
        }()
        return try! encoding.encode(urlRequest, with: params)
    }
}
//swiftlint:enable all
