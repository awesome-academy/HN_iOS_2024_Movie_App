//
//  UIApplication+Extension.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 24/04/2024.
//

import Foundation
import UIKit

extension UIApplication {
    static func reloadRootViewController() {
        guard let window = UIApplication.shared.windows.first,
              let rootViewController = window.rootViewController else { return }
        let storyboard = rootViewController.storyboard
        window.rootViewController = storyboard?.instantiateInitialViewController()
    }
}
