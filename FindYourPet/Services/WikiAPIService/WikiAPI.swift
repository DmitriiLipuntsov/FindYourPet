//
//  BreedsService.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 22.05.2021.
//

import Foundation

import RxSwift
import RxCocoa

typealias JSONObject = [String: Any]

class WikiAPI: WikiAPIProtocol {
    
    static var breed = ""
    
    fileprivate enum Address: String {
        case timeline = "statuses/user_timeline.json"
        case listFeed = "lists/statuses.json"
        case listMembers = "lists/members.json"
        
        private var baseURL: String {
            return "https://api.twitter.com/1.1/"
        }
        var url: URL {
            return URL(string: baseURL.appending(rawValue))!
        }
    }
    
    var listOfDogBreeds = "action=parse&format=json&page=List_of_dog_breeds&prop=links&section=1"
    var listOfCatBreeds = "action=parse&format=json&page=List_of_cat_breeds&prop=links&section=1"
    var AddressForBreed = { "action=query&format=json&prop=pageimages%7Cextracts&titles=\(breed)&piprop=name%7Cthumbnail&pithumbsize=300&explaintext=1"
    }()
    
    private var baseURL: String {
        return "https://en.wikipedia.org/w/api.php?action=parse&format=json&"
    }
    
    func fetchListOfBreeds(of list: String) -> Observable<String> {
        let params = ["action" : "parse",
                      "page": list,
                      "prop": "links",
                      "section": "1"]
        
        let response: Observable<String> = request(parameters: params)
        return response
    }
    
    func fetchBreed(of breed: String) -> Observable<String> {
        let params = ["action" : "query",
                      "prop" : "extracts",
                      "titles" : breed,
                      "explaintext" : "1",
                      "pithumbsize" : "300"]
        
        let response: Observable<String> = request(parameters: params)
        return response
    }
    
    // MARK: - generic request
    private func request<T: Decodable>(
        parameters: [String : String]) -> Observable<T> {
        do {
            guard
                var components = URLComponents(string: baseURL)
            else {
                throw WikiError.invalidURL(baseURL)
            }
            
            components.queryItems =  parameters.map(URLQueryItem.init)
            
            
            guard let finalURL = components.url else {
                throw WikiError.invalidParameter(parameters)
            }
            
            let request = URLRequest(url: finalURL)
            
            return URLSession.shared.rx.response(request: request)
                .map { response, data -> T in
                    do {
                        let list = try JSONDecoder().decode(ListOfBreedsModel<T>.self, from: data)
                        return list.breeds
                    }
                    catch {
                        throw WikiError.invalidDecoderConfiguration
                    }
                }
        }
        catch {
            return Observable.empty()
        }
        
        
    }
    
}
