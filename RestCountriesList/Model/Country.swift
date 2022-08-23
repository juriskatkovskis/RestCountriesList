//
//  Country.swift
//  RestCountriesList
//
//  Created by juris.katkovskis on 23/08/2022.
//

import Foundation
struct Country: Codable{
    let name: Name
}

struct Name: Codable{
    let official, common: String?
}
