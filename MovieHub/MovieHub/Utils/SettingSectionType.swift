//
//  SettingSectionType.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 23/04/2024.
//

import Foundation
import UIKit

enum SettingSectionType: Int {
    case theme
    case language
    case term
    case policy
    case total
    
    var image: UIImage? {
        switch self {
        case .theme:
            return UIImage(named: "theme")
        case .language:
            return UIImage(named: "language")
        case .term:
            return UIImage(named: "term")
        case .policy:
            return UIImage(named: "policy")
        default:
            return nil
        }
    }
    
    var title: String {
        switch self {
        case .theme:
            return "setting.theme".localized()
        case .language:
            return "setting.language".localized()
        case .term:
            return "setting.terms".localized()
        case .policy:
            return "setting.policy".localized()
        default:
            return ""
        }
    }
}
