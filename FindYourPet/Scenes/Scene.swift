//
//  Scene.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 22.05.2021.
//

import Foundation

enum Scene {
    
    case news
    case shelter
    case search
    case account
    case library(Library)
    
    enum Library {
        case dog
        case cat
    }
    
}
