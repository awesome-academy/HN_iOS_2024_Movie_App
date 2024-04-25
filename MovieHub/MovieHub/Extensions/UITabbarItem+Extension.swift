//
//  UITabbarItem+Extension.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 25/04/2024.
//

import Foundation
import UIKit

extension UITabBarItem {
    @IBInspectable var localization: String {
        get {
            return title ?? ""
        }

        set(value) {
            title = value.localized()
        }
    }
}
