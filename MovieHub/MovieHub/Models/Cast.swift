//
//  Cast.swift
//  MovieHub
//
//  Created by nguyen.van.duyb on 4/17/24.
//

import Foundation

struct Cast: Codable {
    let id: Int?
    let name: String?
    let profilePath: String?
    let originalName: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case profilePath = "profile_path"
        case originalName = "original_name"
    }
}
