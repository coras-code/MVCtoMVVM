//
//  Bird.swift
//  MVCtoMVVM
//
//  Created by Cora on 17/03/2022.
//

import Foundation

struct Bird: Codable {
    let comName: String
    let locName: String //location
    let howMany: Int?
    let lat: Double
    let lng: Double
}
