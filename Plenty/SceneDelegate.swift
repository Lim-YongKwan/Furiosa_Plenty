//
//  SceneDelegate.swift
//  Plenty
//
//  Created by 임 용관 on 11/25/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let firstViewController = UINavigationController(rootViewController: RecordViewController())
        let secondViewController = UINavigationController(rootViewController: DiaryViewController())
        let thridViewController = UINavigationController(rootViewController: MeasureViewController())
        let fourthViewController = UINavigationController(rootViewController: MyPageViewController())

        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([firstViewController,secondViewController,thridViewController, fourthViewController], animated: true)
        if let items = tabBarController.tabBar.items {
            items[0].image = UIImage(systemName: "square.and.pencil")
            items[0].title = "기록"
            items[1].image = UIImage(systemName: "fork.knife")
            items[1].title = "일기"
            items[2].image = UIImage(systemName: "calendar")
            items[2].title = "통계"
            items[3].image = UIImage(systemName: "person.circle")
            items[3].title = "MY"
        }
        
        tabBarController.tabBar.backgroundColor = .white
        
        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
    }
}

