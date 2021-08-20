//
//  DescriptionBreedViewModel.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 20.08.2021.
//

import Foundation

struct DescriptionBreedViewModel {
    
    let breedItem: Breed
    
    init(breedItem: Breed, coordinator: SceneCoordinatorType) {
        self.breedItem = breedItem
    }
    
}
