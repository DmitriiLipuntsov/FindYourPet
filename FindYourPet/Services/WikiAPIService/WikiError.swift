//
//  WikiError.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 28.05.2021.
//

import Foundation

enum WikiError: Error {
    case invalidURL(String)
    case invalidParameter([String: Any])
    case invalidJSON(String)
    case invalidDecoderConfiguration
}
