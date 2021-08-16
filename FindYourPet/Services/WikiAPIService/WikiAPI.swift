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
    
    private var baseURL: String {
        return "https://en.wikipedia.org/w/api.php?"
    }

    func fetchBreeds() -> Observable<[Breed]> {
        return fetchListOfBreeds(of: "dog")
            .map { nameBreed -> Observable<Breed> in
                if nameBreed == "Mucuchies" {
                    return Observable.of(Breed(title: "Mucuchies", thumbnail: Thumbnail(source: "https://en.wikipedia.org/wiki/Livestock_guardian_dog#/media/File:Mucuchies_natural_habitat.jpg"), extract: "No description"))
                }
                let formattedBreedName = nameBreed.safeNameBreedForUrl
                return  self.fetchBreed(of: formattedBreedName) }
            .merge()
            .toArray()
            .asObservable()
    }
    
    func fetchListOfBreeds(of list: String) -> Observable<String> {
        let params = "action=parse&format=json&page=List_of_\(list)_breeds&prop=links&section=1"
        let response: Observable<[String]> = request(parameters: params)
        let resp = response
            .map { Observable<String>.from($0) }
            .merge()
        return resp
    }
    
    func fetchBreed(of breed: String) -> Observable<Breed> {
        let params = "action=query&format=json&prop=pageimages%7Cextracts&titles=\(breed)&piprop=name%7Cthumbnail&pithumbsize=300&explaintext=1"
        let response: Observable<Breed> = request(parameters: params)
        return response
    }
    
    // MARK: - generic request
    private func request<T: Decodable>(
        parameters: String) -> Observable<T> {
        do {
            let stringURL = baseURL + parameters
            guard
                let url = URL(string: stringURL)
            else {
                fatalError("Invalid url") //MARK: - temporary
                throw WikiError.invalidURL(baseURL)
            }
            
            let request = URLRequest(url: url)
            
            return URLSession.shared.rx.response(request: request)
                .map { response, data -> T in
                    do {
                        if parameters.hasPrefix("action=parse") {
                            let list = try JSONDecoder().decode(ListOfBreedsModel<T>.self, from: data)
                            guard let breeds = list.breeds else {
                                fatalError("Invalid decoder configuration. No breeds list found.") //MARK: - temporary
                                throw WikiError.invalidDecoderConfiguration
                            }
                            return breeds
                        } else {
                            let object = try JSONDecoder().decode(BreedModel<T>.self, from: data)
                            guard let breed = object.breed else {
                                fatalError("Invalid decoder configuration. Breed no found.") //MARK: - temporary
                                throw WikiError.invalidDecoderConfiguration
                            }
                            return breed
                        }
                    }
                    catch {
                        fatalError("Invalid decoder configuration") //MARK: - temporary
                        throw WikiError.invalidDecoderConfiguration
                    }
                }
        }
        catch {
            return Observable.empty()
        }
    }
}
