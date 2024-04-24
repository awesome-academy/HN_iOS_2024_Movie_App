//
//  LanguageType.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 24/04/2024.
//

import Foundation

enum LanguageType {
    case en
    case vi
    
    var localized: String {
        switch self {
        case .en:
            return "en"
        case .vi:
            return "vi"
        }
    }
}
