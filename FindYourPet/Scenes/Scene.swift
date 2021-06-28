//
//  Scene.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 22.05.2021.
//

import UIKit

enum Scene {
    
    case mainTabBar(RootTabViewModel, LibraryViewModel)
    case news
    case shelter
    case search
    case account
    case library(LibraryViewModel)
    
}

extension Scene {
  func viewController() -> UIViewController {
    switch self {
    case .mainTabBar(let rootTabViewModel, let libraryViewModel):
        let rootTabBarController = RootTabBarController()
        rootTabBarController.bindViewModel(to: rootTabViewModel)
        
        let libraryViewController = LibraryViewController()
        libraryViewController.bindViewModel(to: libraryViewModel)
        let libraryNavigationController = UINavigationController(rootViewController: libraryViewController)
        libraryNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.bookmarks, tag: 0)
        rootTabBarController.viewControllers = [libraryNavigationController]
        
        return rootTabBarController
        
    case .news:
        print(self)
    case .shelter:
        print(self)
    case .search:
        print(self)
    case .account:
        print(self)
    case .library(let viewModel):
        let vc = LibraryViewController()
        vc.bindViewModel(to: viewModel)
        let nc = UINavigationController(rootViewController: vc)
        return nc
    }
    return UIViewController()
  }
}
