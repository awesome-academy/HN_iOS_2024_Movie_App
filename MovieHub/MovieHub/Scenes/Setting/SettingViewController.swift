//
//  SettingViewController.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 23/04/2024.
//

import UIKit
import Reusable
import SafariServices
import Localize_Swift

final class SettingViewController: UIViewController, NibReusable {
    
    @IBOutlet private weak var tableView: UITableView!
    private var sections: [SettingSectionType] = [.theme, .language, .term, .policy]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        title = "setting.title".localized()
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
            showLanguageSelectionAlert { language in
                if Localize.currentLanguage() != language.localized {
                    Localize.setCurrentLanguage(language.localized)
                    UIApplication.reloadRootViewController()
                }
            }
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
                                      message: "setting.theme.title".localized(),
                                      preferredStyle: .actionSheet)

        let darkAction = UIAlertAction(title: "setting.theme.dark".localized(), style: .default) { _ in
            completion(.dark)
        }

        let lightAction = UIAlertAction(title: "setting.theme.light".localized(), style: .default) { _ in
            completion(.light)
        }

        let systemAction = UIAlertAction(title: "setting.theme.system".localized(), style: .default) { _ in
            completion(.unspecified)
        }

        let cancelAction = UIAlertAction(title: "cancel".localized(), style: .cancel, handler: nil)

        alert.addAction(darkAction)
        alert.addAction(lightAction)
        alert.addAction(systemAction)
        alert.addAction(cancelAction)
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    private func showLanguageSelectionAlert(completion: @escaping (LanguageType) -> Void) {
        let alert = UIAlertController(title: nil,
                                      message: "setting.language.title".localized(),
                                      preferredStyle: .actionSheet)
        
        let vnAction = UIAlertAction(title: "setting.language.vn".localized(), style: .default) { _ in
            completion(.vi)
        }
        
        let enAction = UIAlertAction(title: "setting.language.en".localized(), style: .default) { _ in
            completion(.en)
        }
        
        let cancelAction = UIAlertAction(title: "cancel".localized(), style: .cancel, handler: nil)

        alert.addAction(vnAction)
        alert.addAction(enAction)
        alert.addAction(cancelAction)
        navigationController?.present(alert, animated: true, completion: nil)
    }
}

