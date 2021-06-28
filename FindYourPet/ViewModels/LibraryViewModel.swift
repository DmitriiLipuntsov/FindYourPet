//
//  LibraryViewModel.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 22.05.2021.
//

import Foundation
import RxSwift
import RxDataSources

typealias BreedSection = SectionModel<String, String>

struct LibraryViewModel {
    
    private let sceneCoordinator: SceneCoordinatorType
    private let breedsService: WikiAPIProtocol
    
    init(breedsService: WikiAPIProtocol, coordinator: SceneCoordinatorType) {
      self.breedsService = breedsService
      self.sceneCoordinator = coordinator
    }
    
    var listOfBreed: Observable<[BreedSection]> {
        return self.breedsService.fetchListOfBreeds(of: "dog")
            .map { listOfBreed in
                return [BreedSection(model: "", items: listOfBreed)]
            }
    }
    
}
