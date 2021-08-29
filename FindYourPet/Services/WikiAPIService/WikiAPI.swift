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
        return "https://ru.wikipedia.org/w/api.php?"
    }
    
    private var listOfDogBreedsId: String {
        return "1827041"
    }
    
    func fetchBreeds() -> Observable<[Breed]> {
        return getListOfBreeds(by: listOfDogBreedsId)
            .map { id -> Observable<Breed> in
                return self.getBreed(by: id)
            }
            .merge()
            .toArray()
            .asObservable()
    }
    
    private func getListOfBreeds(by id: String) -> Observable<Int> {
        let params = "action=query&format=json&list=categorymembers&utf8=1&cmpageid=\(id)&cmlimit=500"
        let response: Observable<[Int]> = request(parameters: params)
        let resp = response
            .map { Observable<Int>.from($0) }
            .merge()
        return resp
    }
    
    private func getBreed(by id: Int) -> Observable<Breed> {
        let params = "action=query&format=json&prop=pageimages%7Cextracts&pageids=\(id)&piprop=name%7Cthumbnail&pithumbsize=300&redirects=1&explaintext=1&exsectionformat=plain"
        let response: Observable<Breed> = request(parameters: params)
        return response
    }
    
    // MARK: - generic request
    private func request<T: Decodable>(
        parameters: String) -> Observable<T> {
        let stringURL = baseURL + parameters
        guard
            let url = URL(string: stringURL)
        else {
            fatalError("Invalid url") //MARK: - temporary
        }
        
        let request = URLRequest(url: url)
        
        return URLSession.shared.rx.response(request: request)
            .map { response, data -> T in
                if parameters.hasSuffix("cmlimit=500") {
                    return self.decodeJsonListOfBreed(data: data)
                } else {
                    return self.decodeJsonBreedModel(data: data)
                }
            }
    }
    
    //MARK: - DecodeJson
    private func decodeJsonListOfBreed<T: Decodable>(data: Data) -> T {
        do{
            let object = try JSONDecoder().decode(ListOfBreedsModel<T>.self, from: data)
            guard let breed = object.content else {
                fatalError("Invalid decoder configuration. Breed no found.") //MARK: - temporary
            }
            return breed
        }
        catch {
            fatalError("Invalid decoder configuration. Breed no found.")
        }
    }
    
    private func decodeJsonBreedModel<T: Decodable>(data: Data) -> T {
        do{
            let object = try JSONDecoder().decode(BreedModel<T>.self, from: data)
            guard let breed = object.breed else {
                fatalError("Invalid decoder configuration. Breed no found.") //MARK: - temporary
            }
            return breed
        }
        catch {
            fatalError("Invalid decoder configuration. Breed no found.")
        }
    }
    
}
