//
//  SearchMovieCell.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 19/04/2024.
//

import UIKit
import Reusable

final class SearchMovieCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var rateView: UIView!
    @IBOutlet private weak var rateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    private func configView() {
        containerView.layer.cornerRadius = Constants.cornerImage
        containerView.layer.cornerCurve = .continuous
        movieImageView.layer.cornerRadius = Constants.cornerImage
        rateView.layer.cornerRadius = Constants.cornerImage / 3
    }
    
    func configCell(movie: Movie) {
        if let path = movie.poster {
            let movieImagePath = Urls.shared.getImage(urlString: path)
            movieImageView.loadImage(fromURL: movieImagePath)
        }
        if let voteAverage = movie.voteAverage {
            rateLabel.text = "\(voteAverage)"
        } else {
            rateLabel.text = "N/A"
        }
        movieNameLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
    }
    
    func configCell(movie: FavoriteMovie) {
        if let path = movie.poster {
            let movieImagePath = Urls.shared.getImage(urlString: path)
            movieImageView.loadImage(fromURL: movieImagePath)
        }
        rateLabel.text = "\(movie.voteAverage)"
        movieNameLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
    }
}
