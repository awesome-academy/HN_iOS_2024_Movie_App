//
//  UIViewController+Extension.swift
//  MovieHub
//
//  Created by nguyen.van.duyb on 4/16/24.
//

import UIKit
import SafariServices

extension UIViewController {
    func loading(_ isShow: Bool) {
        DispatchQueue.main.async {
            if isShow {
                if self.view.subviews.first(where: { $0.isKind(of: UIActivityIndicatorView.self) }) == nil {
                    let activityIndicator = UIActivityIndicatorView(style: .large)
                    activityIndicator.color = .darkGray
                    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
                    self.view.addSubview(activityIndicator)
                    activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                    activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
                    activityIndicator.startAnimating()
                }
            } else {
                let indicator = self.view.subviews.first(where: { $0.isKind(of: UIActivityIndicatorView.self) })
                indicator?.removeFromSuperview()
            }
        }
    }
    
    func showError(title: String = "error".localized(), message: String = "error.message".localized()) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OkAction = UIAlertAction(title: "OK", style: .default) { (_: UIAlertAction!) in
            }
            alertController.addAction(OkAction)
            self.present(alertController, animated: true)
        }
    }
    
    func showSuccess(title: String = "success".localized(), message: String = "success.message".localized()) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OkAction = UIAlertAction(title: "OK", style: .default) { (_: UIAlertAction!) in
            }
            alertController.addAction(OkAction)
            self.present(alertController, animated: true)
        }
    }
    
    func presentSafariViewController(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
}
