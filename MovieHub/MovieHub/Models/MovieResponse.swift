//
//  MovieResponse.swift
//  MovieHub
//
//  Created by nguyen.van.duyb on 4/17/24.
//

import Foundation

struct MovieResponse: Codable {
    var results: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}
