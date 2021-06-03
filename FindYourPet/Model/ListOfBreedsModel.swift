//
//  ListOfBreedsModel.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 30.05.2021.
//

import Foundation

struct ListOfBreedsModel<Content: Decodable>: Decodable {
    
    let breeds: Content
    var parse: Parse
    
    enum CodingKeys: CodingKey {
        case parse
    }
    
    struct Parse: Decodable {
        var title: String
        var links: [Breed]
    }
    
    struct Breed: Decodable {
        var breed: String
        
        enum CodingKeys: String, CodingKey {
            case breed = "*"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            breed = try container.decode(String.self, forKey: .breed)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        parse = try container.decode(Parse.self, forKey: .parse)
        let breedsModel = try container.decode(Parse.self, forKey: .parse).links
        breeds = breedsModel.compactMap { $0.breed } as! Content
        print(breeds)
    }
}
