//
//  ActorInfoCell.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 23/04/2024.
//

import UIKit
import Reusable

final class ActorInfoCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var backdropImageView: UIImageView!
    @IBOutlet private weak var actorImageView: UIImageView!
    @IBOutlet private weak var actorNameLabel: UILabel!
    @IBOutlet private weak var actorBioLabel: UILabel!
    @IBOutlet private weak var actorKnownAsLabel: UILabel!
    @IBOutlet private weak var actorDateLabel: UILabel!
    @IBOutlet private weak var actorPlaceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        actorBioLabel.numberOfLines = 4
        actorImageView.layer.cornerRadius = 12
        actorImageView.layer.cornerCurve = .continuous
        actorImageView.layer.borderColor = UIColor.white.cgColor
        actorImageView.layer.borderWidth = 3
        backdropImageView.addGradientOverlay()
    }
    
    func setContentForCell(actor: Actor) {
        actorBioLabel.text = actor.biography
        actorDateLabel.text = "actor.birthday".localized() + (actor.birthday ?? "")
        actorNameLabel.text = actor.name
        actorKnownAsLabel.text = "actor.knownas".localized() +  (actor.knownFor ?? "")
        actorPlaceLabel.text = "actor.place".localized() +  (actor.place ?? "")
        let actorImageString = Urls.shared.getImage(urlString: actor.profilePath ?? "")
        actorImageView.loadImage(fromURL: actorImageString)
        backdropImageView.loadImage(fromURL: actorImageString)
    }
}
