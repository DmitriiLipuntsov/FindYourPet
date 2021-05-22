//
//  Scene.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 22.05.2021.
//

import UIKit

enum Scene {
    
    case news
    case shelter
    case search
    case account
    case library(LibraryViewModel)
    
}

extension Scene {
  func viewController() -> UIViewController {
    switch self {
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
