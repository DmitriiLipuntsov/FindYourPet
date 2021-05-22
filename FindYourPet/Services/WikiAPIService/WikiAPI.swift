//
//  BreedsService.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 22.05.2021.
//

import Foundation

import RxSwift
import RxCocoa

class WikiAPI: WikiAPIProtocol {
    
    enum TypeOfAnimal: String {
        case cat = "cat"
        case dog = "dog"
    }
    
    private var baseURL: String {
        return "https://en.wikipedia.org/w/api.php?"
    }
    
    // MARK: - generic request
    
    
    
}
//action=parse&format=json&page=List_of_dog_breeds&prop=links&section=1
extension String {
    var safeFileNameRepresentation: String {
        return replacingOccurrences(of: "?", with: "-")
                .replacingOccurrences(of: "&", with: "-")
                .replacingOccurrences(of: "=", with: "-")
    }
}

extension URL {
    var safeLocalRepresentation: URL {
        return URL(string: absoluteString.safeFileNameRepresentation)!
    }
}
