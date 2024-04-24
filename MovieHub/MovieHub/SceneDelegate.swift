//
//  SceneDelegate.swift
//  MovieHub
//
//  Created by nguyen.van.duyb on 4/16/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        setupTheme()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

extension SceneDelegate {
    private func setupTheme() {
        guard let rawValue = UserDefaults.standard.value(forKey: UserDefaultsKey.theme.rawValue) as? Int,
              let theme = ThemeType(rawValue: rawValue),
              let window = window else { return }
        window.overrideUserInterfaceStyle = theme.uiUserInterfaceStyle
    }
}
