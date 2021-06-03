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
        let service =  WikiAPI()
        let _ = service.fetchListOfBreeds(of: "dog").subscribe(onNext: { observer in
            print("-----------_________---------",observer)
        })
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = LibraryViewController()
        window?.makeKeyAndVisible()
    }
    
}

