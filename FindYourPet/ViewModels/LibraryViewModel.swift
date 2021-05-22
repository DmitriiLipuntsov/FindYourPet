//
//  LibraryViewModel.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 22.05.2021.
//

import Foundation

struct LibraryViewModel {
    
    private let sceneCoordinator: SceneCoordinatorType
    private let breedsService: WikiAPIProtocol
    
    init(breedsService: WikiAPIProtocol, coordinator: SceneCoordinatorType) {
      self.breedsService = breedsService
      self.sceneCoordinator = coordinator
    }
    
}
