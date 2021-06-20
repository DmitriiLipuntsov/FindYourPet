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
        breed = query.pages.breed as? Content
    }
}

// MARK: - Query
struct Query: Codable {
    let pages: PageId
}

// MARK: - PageId
struct PageId: Codable {
    let breed: Breed

    enum CodingKeys: String, CodingKey {
        case breed = "273885"
    }
}

// MARK: - Page
struct Breed: Codable {
    let title: String
    let thumbnail: Thumbnail
    let extract: String
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let source: String
}
