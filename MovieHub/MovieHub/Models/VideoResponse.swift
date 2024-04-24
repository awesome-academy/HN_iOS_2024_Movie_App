//
//  VideoResponse.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 23/04/2024.
//

import Foundation

struct VideoResponse: Codable {
    var results: [Video]?
    enum CodingKeys: String, CodingKey {
        case results
    }
}
