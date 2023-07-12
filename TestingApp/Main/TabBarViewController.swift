//
//  TabBarViewController.swift
//  TestingApp
//
//  Created by Лидия Пятаева on 02.07.2023.
//

import UIKit

//protocol TabBarControllerDelegate: AnyObject {
//    func addToCartButtonTapped(dish: Dishes)
//}

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        selectedIndex = 0
        setTabBarAppearance()
    }
    
    private func setupControllers() {
        
        let mainViewController = UINavigationController(rootViewController: MainViewController())
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        let basketViewController = BasketViewController()
        let accountViewController = UINavigationController(rootViewController: AccountViewController())
      
        
        viewControllers = [
            generateVC(viewController: mainViewController,
                       title: "Главная",
                       image: UIImage(named: "главная")),
            generateVC(viewController: searchViewController,
                       title: "Поиск",
                       image: UIImage(named: "поиск")),
            generateVC(viewController: basketViewController,
                       title: "Корзина",
                       image: UIImage(named: "корзина")),
            generateVC(viewController: accountViewController,
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
    
    
    



