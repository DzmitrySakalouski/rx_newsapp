//
//  MainHomeViewController.swift
//  rx_newsapp
//
//  Created by Dzmitry  Sakalouski  on 3/12/20.
//  Copyright © 2020 Dzmitry  Sakalouski . All rights reserved.
//

import UIKit

class MainHomeViewController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.delegate = self
        
        configureViewControllers()
    }
    
    private func configureViewControllers() {
        let horoscopeVC = constructNacController(tabName: "Horoscope",rootViewController: HoroscopeViewController())
        let compatibilityVC = constructNacController(tabName: "Campatibility", rootViewController: CompatibilityViewController())
        viewControllers = [horoscopeVC, compatibilityVC]
        tabBar.tintColor = Colors.COLOR_DARK_BLUE
        tabBar.backgroundColor = Colors.COLOR_DARK_BLUE
        tabBar.shadowImage = UIImage()
        tabBarController?.navigationController?.navigationBar.backgroundColor = Colors.COLOR_DARK_BLUE
    }
    
    func constructNacController(tabName: String, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        rootViewController.navigationController?.navigationBar.isHidden = true
        
        let tabBarAppearance = tabBar.standardAppearance
        tabBarAppearance.shadowImage = nil
        tabBarAppearance.shadowColor = nil
        tabBarAppearance.backgroundColor = Colors.COLOR_DARK_BLUE
        tabBar.standardAppearance = tabBarAppearance
        
        let navController = UINavigationController(rootViewController: rootViewController)
        
        navController.navigationBar.isHidden = true
        navController.tabBarItem.title = tabName
        navController.tabBarController?.tabBar.backgroundColor = Colors.COLOR_DARK_BLUE
        tabBar.backgroundImage = UIImage()
        
        
        return navController
    }

}
