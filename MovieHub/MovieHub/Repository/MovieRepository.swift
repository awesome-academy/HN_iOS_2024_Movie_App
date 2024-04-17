//
//  MovieRepository.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 19/04/2024.
//

import Foundation
import UIKit

protocol MovieRepositoryType {
    func getMovies(urlString: String, completion: @escaping(Result<MovieResponse, Error>) -> Void)
    func getMovieDetail(id: Int, completion: @escaping(Result<Movie, Error>) -> Void)
}

struct MovieRepository: MovieRepositoryType {
    func getMovies(urlString: String, completion: @escaping((Result<MovieResponse, Error>) -> ())) {
        APIService.shared.get(urlString: urlString, completion: completion)
    }
    
    func getMovieDetail(id: Int, completion: @escaping ((Result<Movie, Error>) -> Void)) {
        let urlString = Urls.shared.getMovieDetailUrl(id: id)
        APIService.shared.get(urlString: urlString, completion: completion)
    }
}
