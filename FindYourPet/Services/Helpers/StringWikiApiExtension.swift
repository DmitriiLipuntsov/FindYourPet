//
//  String + Extension.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 15.08.2021.
//

import Foundation

extension String {
    var safeNameBreedForUrl: String {
        var str = self
        if str == "Cursinu" {
            str = "Corsican Dog"
        }
        return str.replacingOccurrences(of: " ", with: "%20")
            .replacingOccurrences(of: "&", with: "%26")
            .replacingOccurrences(of: "ñ", with: "%C3%b1")
            .replacingOccurrences(of: "ç", with: "%C3%A7")
            .replacingOccurrences(of: "é", with: "%C3%A9")
            .replacingOccurrences(of: "è", with: "%C3%A8")
            .replacingOccurrences(of: "í", with: "%C3%AD")
            .replacingOccurrences(of: "ó", with: "%C3%B3")
            .replacingOccurrences(of: "ã", with: "%C3%A3")
            .replacingOccurrences(of: "ń", with: "%C5%84")
            .replacingOccurrences(of: "ö", with: "%C3%B6")
            .replacingOccurrences(of: "ä", with: "%C3%A4")
            .replacingOccurrences(of: "ü", with: "%C3%BC")
            .replacingOccurrences(of: "á", with: "%C3%A1")
            .replacingOccurrences(of: "ž", with: "%C5%BE")
            .replacingOccurrences(of: "ř", with: "%C5%99")
            .replacingOccurrences(of: "ý", with: "%C3%BD")
            .replacingOccurrences(of: "Š", with: "%C5%A0")
    }
}
