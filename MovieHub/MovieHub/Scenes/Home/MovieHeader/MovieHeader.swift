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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configView(title: String) {
        headerTitle.text = title
    }
}
