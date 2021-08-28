//
//  BreedModel.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 03.06.2021.
//

import Foundation

struct BreedModel<Content>: Decodable {
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
            fatalError("Found more than one page for the request") // сделал временно чтобы точно знать когда значений приходит больше одного
        }
        self.breed = pages[0] as? Content
    }
}

// MARK: - Query
struct Query: Codable {
    let pages: [String : Breed]
}

// MARK: - Page
struct Breed: Codable, Comparable {
    let title: String
    let thumbnail: Thumbnail?
    let extract: String
    
    static func < (lhs: Breed, rhs: Breed) -> Bool {
        return lhs.title < rhs.title
    }
    
    static func == (lhs: Breed, rhs: Breed) -> Bool {
        return lhs.title == rhs.title
    }
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let source: String
}
