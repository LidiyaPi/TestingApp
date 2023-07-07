//
//  TabBarViewController.swift
//  TestingApp
//
//  Created by Лидия Пятаева on 02.07.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        selectedIndex = 0
        setTabBarAppearance()
//        tabBar.tintColor = .systemGreen
//        tabBar.unselectedItemTintColor = .systemGray
        
    }
    
    private func setupControllers() {
        
        let navigationControllerGen = UINavigationController(rootViewController: MainViewController())
        let navigationControllerSea = UINavigationController(rootViewController: SearchViewController())
        let navigationControllerBas = UINavigationController(rootViewController: BasketViewController())
        let navigationControllerAcc = UINavigationController(rootViewController: AccountViewController())

        viewControllers = [
            generateVC(viewController: navigationControllerGen,
                       title: "Главная",
                       image: UIImage(named: "главная")),
            generateVC(viewController: navigationControllerSea,
                       title: "Поиск",
                       image: UIImage(named: "поиск")),
            generateVC(viewController: navigationControllerBas,
                       title: "Корзина",
                       image: UIImage(named: "корзина")),
            generateVC(viewController: navigationControllerAcc,
                       title: "Аккаунт",
                       image: UIImage(named: "аккаунт"))
        ]
        
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.image = image
        viewController.tabBarItem.title = title
        return viewController
    }
    
    private func setTabBarAppearance() {
        
        self.tabBar.itemPositioning = .fill
    }
}

