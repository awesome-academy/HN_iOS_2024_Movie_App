//
//  Credits.swift
//  MovieHub
//
//  Created by nguyen.van.duyb on 4/17/24.
//

import Foundation

struct Credits: Codable {
    var id: Int?
    var cast: [Cast]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case cast
    }
}
