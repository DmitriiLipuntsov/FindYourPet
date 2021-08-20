//
//  LibraryViewModel.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 22.05.2021.
//

import Foundation
import RxSwift
import RxDataSources

typealias BreedSection = SectionModel<String, Breed>

class LibraryViewModel {
    
    private let sceneCoordinator: SceneCoordinatorType
    private let breedsService: WikiAPIProtocol
    
    private var allBreeds: [Breed] = []
    private var sortedBreeds: [Breed] = []
    
    private let disposeBag = DisposeBag()
    let searchBreed: BehaviorSubject<[BreedSection]> = BehaviorSubject(value: [BreedSection(model: "", items: [])])
    
    init(breedsService: WikiAPIProtocol, coordinator: SceneCoordinatorType) {
        self.breedsService = breedsService
        self.sceneCoordinator = coordinator
        getBreedsSection()
    }
    
    
    
    private func getBreedsSection() {
        breedsService.fetchBreeds().subscribe(onNext: { breeds in
            let sortBreeds = breeds.sorted()
            self.allBreeds.append(contentsOf: sortBreeds)
            self.sortedBreeds.append(contentsOf: sortBreeds)
            self.searchBreed.onNext([BreedSection(model: "", items: sortBreeds)])
        }).disposed(by: disposeBag)
    }
    
    func searchCencelButtonTapped() {
        searchBreed.onNext([BreedSection(model: "", items: allBreeds)])
    }
    
    func actionForCellSelected(breedItem: Breed) {
        let descriptionBreedViewModel = DescriptionBreedViewModel(
            breedItem: breedItem,
            coordinator: self.sceneCoordinator)
        sceneCoordinator.transition(to: Scene.descriptionBreed(descriptionBreedViewModel), type: .modal)
    }
    
    func getSortedBreeds(with name: String) {
        sortedBreeds = allBreeds.filter({ $0.title.hasPrefix(name) })
        searchBreed.onNext([BreedSection(model: "", items: sortedBreeds)])
    }
}
