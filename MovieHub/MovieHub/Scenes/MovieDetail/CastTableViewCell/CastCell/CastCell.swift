//
//  CastCell.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 18/04/2024.
//

import UIKit
import Reusable

final class CastCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var castImageView: UIImageView!
    @IBOutlet private weak var castNameLabel: UILabel!
    @IBOutlet private weak var originNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        containerView.layer.cornerRadius = Constants.cornerImage
        containerView.layer.cornerCurve = .continuous
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        castImageView.layer.cornerCurve = .continuous
        castImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        castImageView.layer.cornerRadius = Constants.cornerImage
        
        castNameLabel.textColor = .secondaryLabel
        originNameLabel.textColor = .secondaryLabel
    }
    
    func configCell(info: Cast) {
        if let profilePath = info.profilePath, !profilePath.isEmpty {
            let posterURl = Urls.shared.getImage(urlString: profilePath)
            castImageView.loadImage(fromURL: posterURl)
        } else {
            castImageView.image = UIImage(named: "default_image")
        }
        castNameLabel.text = info.name
        originNameLabel.text = info.originalName
    }
}
