//
//  MovieCredits.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 23/04/2024.
//

import Foundation

struct MovieCredits: Codable {
    var movies: [Movie]?
    enum CodingKeys: String, CodingKey {
        case movies = "cast"
    }
}
