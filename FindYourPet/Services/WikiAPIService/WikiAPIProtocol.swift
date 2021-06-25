//
//  BreedsServiceType.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 22.05.2021.
//

import Foundation
import RxSwift

protocol WikiAPIProtocol {
    func fetchListOfBreeds(of list: String) -> Observable<[String]>
}
