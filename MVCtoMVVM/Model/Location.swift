//
//  Location.swift
//  MVCtoMVVM
//
//  Created by M_931521 on 18/08/2022.
//

import Foundation

struct LocationData: Codable {
    let type: String
    var features: [Address]
}

struct Address: Codable {
    var properties: Properties
}

struct Properties: Codable {
    let country: String?
    let housenumber: String? 
    let name: String?
}
