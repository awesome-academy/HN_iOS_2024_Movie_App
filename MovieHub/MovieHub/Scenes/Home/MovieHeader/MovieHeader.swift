//
//  MovieHeader.swift
//  MovieHub
//
//  Created by nguyen.van.duyb on 4/17/24.
//

import UIKit
import Reusable

final class MovieHeader: UITableViewHeaderFooterView, NibReusable {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var headerTitle: UILabel!
    @IBOutlet private weak var seeMoreButton: UIButton!
    
    var showMoreTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configHeaderView()
    }
    
    private func configHeaderView() {
        seeMoreButton.setTitle("home.seemore".localized(), for: .normal)
    }
    
    func configView(title: String) {
        headerTitle.text = title
    }
    
    @IBAction func tappedShowMore(_ sender: Any) {
        showMoreTapped?()
    }
}
