//
//  Video.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 23/04/2024.
//

import Foundation

struct Video: Codable {
    var key: String?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case key
        case name
    }
}
