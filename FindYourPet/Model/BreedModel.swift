//
//  BreedModel.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 03.06.2021.
//

import Foundation

struct BreedModel<Content: Decodable>: Decodable {
    let breed: Content?
    let query: Query
    
    enum CodingKeys: CodingKey {
        case page, query
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        query = try container.decode(Query.self, forKey: .query)
        let pages = [Breed](query.pages.values)
        if pages.count != 1 {
            print("Found more than one page for the request")
        }
        self.breed = pages[0] as? Content
    }
}

// MARK: - Query
struct Query: Codable {
    let pages: [String : Breed]
}

// MARK: - Page
struct Breed: Codable {
    let title: String
    let thumbnail: Thumbnail?
    let extract: String
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let source: String
}
