//
//  TrailerCell.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 18/04/2024.
//

import UIKit
import Reusable

final class TrailerCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var backDropImageView: UIImageView!
    @IBOutlet private weak var playImageView: UIImageView!
    @IBOutlet private weak var movieName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        containerView.layer.cornerRadius = Constants.cornerImage
        containerView.layer.cornerCurve = .continuous
        
        backDropImageView.layer.cornerRadius = Constants.cornerImage
        backDropImageView.layer.cornerCurve = .continuous
    }
    
    func configCell(movie: Movie) {
        
    }
    
    func configSimilarCell(movie: Movie) {
        playImageView.isHidden = true
        if let path = movie.backDropPath {
            let backDropPath = Urls.shared.getImage(urlString: path)
            backDropImageView.loadImage(fromURL: backDropPath)
        }
        movieName.text = movie.title
    }
}
