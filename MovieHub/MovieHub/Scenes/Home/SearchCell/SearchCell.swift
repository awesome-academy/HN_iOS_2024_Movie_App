//
//  SearchCell.swift
//  MovieHub
//
//  Created by nguyen.van.duyb on 4/17/24.
//

import UIKit
import Reusable

final class SearchCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bioLabel: UILabel!
    @IBOutlet private weak var searchImageView: UIImageView!
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var searchPlaceholder: UILabel!
    @IBOutlet private weak var searchButton: UIButton!
    
    var tappedSearch: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        titleLabel.text = "home.welcome".localized()
        bioLabel.text = "home.bio".localized()
        searchImageView.addGradientOverlay()
        searchView.layer.cornerRadius = 12.0
        searchView.layer.cornerCurve = .continuous
        searchPlaceholder.font = .systemFont(ofSize: 14)
        searchPlaceholder.textColor = .secondaryLabel
        searchPlaceholder.text = "home.search".localized()
    }
    
    @IBAction func searchAction(_ sender: Any) {
        tappedSearch?()
    }
}
