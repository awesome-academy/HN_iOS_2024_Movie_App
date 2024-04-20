//
//  StarRatingView.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 22/04/2024.
//

import UIKit

final class StarRatingView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 2
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func addStarImageViews(count: Int, imageSize: CGFloat = 20) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for _ in 0..<count {
            let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
            starImageView.tintColor = .yellow
            starImageView.contentMode = .scaleToFill
            starImageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
            starImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
            stackView.addArrangedSubview(starImageView)
        }
    }
}
