//
//  UIImageView+Extension.swift
//  MovieHub
//
//  Created by nguyen.van.duyb on 4/17/24.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(fromURL url: String) {
        APIService.shared.loadImageFromUrl(urlString: url) { [weak self] image, error in
            guard let self = self else { return }
            if let image = image {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func addGradientOverlay(startColor: UIColor = .clear, endColor: UIColor = .black) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.locations = [0.5, 1.0]
        layer.addSublayer(gradientLayer)
    }
}
