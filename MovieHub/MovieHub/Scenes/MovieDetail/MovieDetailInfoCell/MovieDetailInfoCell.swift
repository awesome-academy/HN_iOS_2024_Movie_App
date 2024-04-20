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
    @IBOutlet private weak var starView: StarRatingView!
    @IBOutlet private weak var widthStarViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var overViewTitle: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    var tappedFavorite: ((Movie) -> Void)?
    var tappedPlay: (() -> Void)?
    private var movie: Movie?
    private var numberOfStackView = 0 {
        didSet {
            updateStackView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        backDropImageView.addGradientOverlay()
        posterImageView.layer.cornerRadius = Constants.cornerImage
        posterImageView.layer.cornerCurve = .continuous
        posterImageView.layer.borderColor = UIColor.white.cgColor
        posterImageView.layer.borderWidth = 3
        favoriteButton.tintColor = .systemPink
        let configuration = UIImage.SymbolConfiguration(pointSize: 40)
        playButton.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        playButton.tintColor = .white
        movieNameLabel.textColor = .white
        descriptionLabel.textColor = .secondaryLabel
    }
    
    private func updateStackView() {
        starView.addStarImageViews(count: numberOfStackView)
        widthStarViewConstraint.constant = CGFloat(numberOfStackView) * 20 + CGFloat(numberOfStackView - 1) * 2
    }
    
    func configCell(movie: Movie, isFavorite: Bool) {
        descriptionLabel.text = movie.overview
        movieNameLabel.text = movie.title
        timeLabel.text = "Run time: \(movie.runtime ?? 0)"
        numberOfStackView = Int((movie.voteAverage ?? 10) / 2)
        self.movie = movie
        let backDropUrl = Urls.shared.getImage(urlString: movie.backDropPath ?? "")
        backDropImageView.loadImage(fromURL: backDropUrl)
        let posterUrl = Urls.shared.getImage(urlString: movie.poster ?? "")
        posterImageView.loadImage(fromURL: posterUrl)
        updateFavoriteButtonImage(isFavorite: isFavorite)
    }
    
    func updateFavoriteButtonImage(isFavorite: Bool) {
        let imageName = isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @IBAction func tappedFavoriteButton(_ sender: Any) {
        guard let movie = movie else { return }
        tappedFavorite?(movie)
    }
    
    @IBAction func tappedPlayButton(_ sender: Any) {
        tappedPlay?()
    }
}
