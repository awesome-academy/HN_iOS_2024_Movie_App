//
//  HomeSectionType.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 23/04/2024.
//

import Foundation

enum HomeSectionType: Int, CaseIterable {
    case search = 0
    case popular
    case topRated
    case upComing
    case nowPlaying
    
    var title: String {
        switch self {
        case .search:
            return ""
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upComing:
            return "Up coming"
        case .nowPlaying:
            return "Now playing"
        }
    }
    
    var urlString: String {
        switch self {
        case .search:
            return ""
        case .popular:
            return "popular"
        case .topRated:
            return "top_rated"
        case .upComing:
            return "upcoming"
        case .nowPlaying:
            return "now_playing"
        }
    }
}
