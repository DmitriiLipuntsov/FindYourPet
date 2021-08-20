//
//  ListOfBreedsModel.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 30.05.2021.
//

import Foundation

struct ListOfBreedsModel<Content>: Decodable {
    
    let breeds: Content?
    var parse: Parse
    
    enum CodingKeys: CodingKey {
        case parse
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        parse = try container.decode(Parse.self, forKey: .parse)
        var breedsModel = try container.decode(Parse.self, forKey: .parse).links
        breedsModel.removeLast(2)
        breeds = breedsModel.compactMap({ $0.breedName }) as? Content
    }
}


struct Parse: Decodable {
    var title: String
    var links: [BreedName]
}

struct BreedName: Decodable {
    var breedName: String
    
    enum CodingKeys: String, CodingKey {
        case breedName = "*"
    }
}
