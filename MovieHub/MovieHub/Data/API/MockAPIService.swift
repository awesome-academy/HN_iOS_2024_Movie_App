//
//  MockAPIService.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 06/05/2024.
//

import Foundation
import UIKit

class MockAPIService: APIServiceProtocol {
    
    static let shared = MockAPIService()
    private init() {}
    
    func loadImageFromUrl(urlString: String, completion: @escaping (UIImage?, Error?) -> Void) {
        
    }
    
    func get<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        var mockMovie1 = Movie()
        mockMovie1.id = 1
        mockMovie1.title = "Mock Movie 1"
        mockMovie1.voteAverage = 7.5
        
        var mockMovie2 = Movie()
        mockMovie2.id = 2
        mockMovie2.title = "Mock Movie 2"
        mockMovie2.voteAverage = 8.0
        
        var mockMovie3 = Movie()
        mockMovie3.id = 3
        mockMovie3.title = "Mock Movie 3"
        mockMovie3.voteAverage = 10.0
        
        var mockMovie4 = Movie()
        mockMovie4.id = 4
        mockMovie4.title = "Mock Movie 4"
        mockMovie4.voteAverage = 9.0
        
        let mockMovieResponse = MovieResponse(results: [mockMovie1, mockMovie2, mockMovie3, mockMovie4])
        
        completion(.success(mockMovieResponse as! T))
    }
}
