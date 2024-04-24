//
//  SettingCell.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 23/04/2024.
//

import UIKit
import Reusable

final class SettingCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var settingImageView: UIImageView!
    @IBOutlet private weak var settingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        containerView.layer.cornerRadius = Constants.cornerImage
        containerView.layer.cornerCurve = .continuous
    }
    
    func configCell(for sectionType: SettingSectionType) {
        settingImageView.image = sectionType.image
        settingLabel.text = sectionType.title
    }
}
