//
//  MovieCollectionViewCell.swift
//  MovieHub
//
//  Created by nguyen.van.duyb on 4/17/24.
//

import UIKit
import Reusable

final class MovieCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var movieName: UILabel!
    @IBOutlet private weak var releaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        posterImageView.layer.cornerRadius = 12
        releaseDate.textColor = .secondaryLabel
    }
    
    func configCell(movie: Movie) {
        movieName.text = movie.title
        releaseDate.text = movie.releaseDate
        let posterImageString = Urls.shared.getImage(urlString: movie.poster ?? "")
        posterImageView.loadImage(fromURL: posterImageString)
    }
}
