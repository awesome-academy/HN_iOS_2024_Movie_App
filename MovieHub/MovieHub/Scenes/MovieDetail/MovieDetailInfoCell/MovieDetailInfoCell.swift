//
//  MovieDetailInfoCell.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 18/04/2024.
//

import UIKit
import Reusable

final class MovieDetailInfoCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var backDropImageView: UIImageView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var rateView: UIView!
    @IBOutlet private weak var overViewTitle: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    var tappedFavorite: (() -> Void)?
    var tappedPlay: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        posterImageView.layer.cornerRadius = Constants.cornerImage
        posterImageView.layer.cornerCurve = .continuous
        posterImageView.layer.borderColor = UIColor.white.cgColor
        posterImageView.layer.borderWidth = 3
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 40)
        playButton.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        playButton.tintColor = .white
        
        movieNameLabel.textColor = .white
        descriptionLabel.textColor = .secondaryLabel
    }
    
    func configCell(movie: Movie) {
        DispatchQueue.main.async {
            self.configUI(movie: movie)
        }
    }
    
    private func configUI(movie: Movie) {
        let backDropUrl = Urls.shared.getImage(urlString: movie.backDropPath ?? "")
        backDropImageView.loadImage(fromURL: backDropUrl)
        let posterUrl = Urls.shared.getImage(urlString: movie.poster ?? "")
        posterImageView.loadImage(fromURL: posterUrl)
        let favoriteImage = movie.isFavorite
        ? UIImage(systemName: "heart.fill")
        : UIImage(systemName: "heart")
        favoriteButton.setImage(favoriteImage, for: .normal)
        descriptionLabel.text = movie.overview
        movieNameLabel.text = movie.title
        timeLabel.text = "Run time: \(movie.runtime ?? 0)"
    }
    
    @IBAction func tappedFavoriteButton(_ sender: Any) {
        tappedFavorite?()
    }
    
    @IBAction func tappedPlayButton(_ sender: Any) {
        tappedPlay?()
    }
}
