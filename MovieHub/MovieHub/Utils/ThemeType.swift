//
//  ThemeType.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 23/04/2024.
//

import Foundation
import UIKit

enum ThemeType: Int {
    case unspecified
    case light
    case dark
    
    var uiUserInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .unspecified:
            return .unspecified
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
