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
        let horoscopeVC = constructNacController(unselectedImage: #imageLiteral(resourceName: "horoscope"), selectedImage: #imageLiteral(resourceName: "horoscope_selected"), rootViewController: HoroscopeViewController())
        let compatibilityVC = constructNacController(unselectedImage:#imageLiteral(resourceName: "compatibility"), selectedImage: #imageLiteral(resourceName: "compatibility_selected"), rootViewController: CompatibilityViewController())
        let profileVC = constructNacController(unselectedImage: #imageLiteral(resourceName: "profile"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: ProfileViewController())
        viewControllers = [horoscopeVC, compatibilityVC, profileVC]
        tabBar.tintColor = Colors.COLOR_WHITE
        tabBar.backgroundColor = Colors.COLOR_DARK_BLUE
        tabBar.shadowImage = UIImage()
        tabBarController?.navigationController?.navigationBar.backgroundColor = Colors.COLOR_DARK_BLUE
    }
    
    func constructNacController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let tabBarAppearance = tabBar.standardAppearance
        tabBarAppearance.shadowImage = nil
        tabBarAppearance.shadowColor = nil
        tabBarAppearance.backgroundColor = Colors.COLOR_DARK_BLUE
        tabBar.standardAppearance = tabBarAppearance
        
        tabBarController?.navigationController?.navigationBar.isHidden = true
        
        let navController = UINavigationController(rootViewController: rootViewController)
        
        navController.navigationBar.isHidden = true
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        navController.tabBarController?.tabBar.backgroundColor = Colors.COLOR_DARK_BLUE
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        return navController
    }

}
