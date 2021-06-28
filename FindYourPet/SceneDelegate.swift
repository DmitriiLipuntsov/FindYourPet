//
//  SceneDelegate.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 20.05.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        let service =  WikiAPI()
        let sceneCoordinator = SceneCoordinator(window: window!)
        
        let rootTabBarViewModel = RootTabViewModel(sceneCoordinator: sceneCoordinator)
        let libraryViewModel = LibraryViewModel(breedsService: service, coordinator: sceneCoordinator)
        let mainScene = Scene.mainTabBar(rootTabBarViewModel, libraryViewModel)
        sceneCoordinator.transition(to: mainScene, type: .root)
    }
    
}

