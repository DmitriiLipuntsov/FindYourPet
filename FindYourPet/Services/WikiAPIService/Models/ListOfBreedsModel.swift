//
//  ListOfBreedsModel.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 28.08.2021.
//

import Foundation

struct ListOfBreedsModel<Content>: Decodable {
    
    let content: Content?
    let query: Query
    
    enum CodingKeys: CodingKey {
        case query, content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        query = try container.decode(Query.self, forKey: .query)
        let breedsModel = try container.decode(Query.self, forKey: .query).categoryMembers
        content = breedsModel.compactMap({ $0.pageid }) as? Content
    }
    
    struct Query: Decodable {
        let categoryMembers: [CategoryMembers]
        
        enum CodingKeys: String, CodingKey {
            case categoryMembers = "categorymembers"
        }
    }
    
    struct CategoryMembers: Decodable {
        let pageid: Int
        let title: String
    }
    
}
