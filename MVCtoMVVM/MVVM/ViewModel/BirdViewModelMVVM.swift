//
//  BirdViewModel.swift
//  MVCtoMVVM
//
//  Created by Cora on 08/03/2022.
//

import Foundation
import UIKit

struct BirdViewModelMVVM {
    
    let name: String
    
    let detailTextString: String
    let accessoryType: UITableViewCell.AccessoryType
    
    // Dependency Injection (DI)
    init(bird: BirdMVVM) {
        self.name = bird.comName
        if bird.howMany != nil {
            if bird.howMany! > 10 {
                detailTextString = "10+ birds sighted here"
                accessoryType = .detailDisclosureButton
            } else {
                detailTextString = "\(bird.howMany!) birds sighted at \(bird.locName)"
                accessoryType = .none
            }
        } else {//need to deal with nil better
            detailTextString = "The number of birds sighted here is unknown"
            accessoryType = .none
        }
    }
    
}
