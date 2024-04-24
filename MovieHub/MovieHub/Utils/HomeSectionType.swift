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
            return "home.popular".localized()
        case .topRated:
            return "home.topRated".localized()
        case .upComing:
            return "home.upcoming".localized()
        case .nowPlaying:
            return "home.nowplaying".localized()
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
