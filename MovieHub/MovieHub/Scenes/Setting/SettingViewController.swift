//
//  SettingViewController.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 23/04/2024.
//

import UIKit
import Reusable
import SafariServices

final class SettingViewController: UIViewController, NibReusable {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    private var sections: [SettingSectionType] = [.theme, .language, .term, .policy]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(cellType: SettingCell.self)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SettingCell.self)
        let sectionType = sections[indexPath.section]
        cell.selectionStyle = .none
        cell.configCell(for: sectionType)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .theme:
            showThemeSelectionAlert { theme in
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = theme.uiUserInterfaceStyle
                    UserDefaults.standard.set(window.overrideUserInterfaceStyle.rawValue,
                                              forKey: UserDefaultsKey.theme.rawValue)
                }
            }
        case .language:
            print("Language cell selected")
        case .term:
            presentSafariViewController(with: Urls.shared.getTermsUrl())
        case .policy:
            presentSafariViewController(with: Urls.shared.getPolicyUrl())
        default:
            break
        }
    }
}


extension SettingViewController {
    private func showThemeSelectionAlert(completion: @escaping (ThemeType) -> Void) {
        let alert = UIAlertController(title: nil,
                                      message: "Select Theme",
                                      preferredStyle: .actionSheet)

        let darkAction = UIAlertAction(title: "Dark", style: .default) { _ in
            completion(.dark)
        }

        let lightAction = UIAlertAction(title: "Light", style: .default) { _ in
            completion(.light)
        }

        let systemAction = UIAlertAction(title: "System", style: .default) { _ in
            completion(.unspecified)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(darkAction)
        alert.addAction(lightAction)
        alert.addAction(systemAction)
        alert.addAction(cancelAction)
        navigationController?.present(alert, animated: true, completion: nil)
    }
}
