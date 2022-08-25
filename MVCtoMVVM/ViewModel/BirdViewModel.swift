//
//  ModelView.swift
//  MVCtoMVVM
//
//  Created by M_931521 on 23/03/2022.
//

import Foundation
import UIKit

struct BirdViewModel {
    let name: String
    let birdsSighted: String
    let accessoryType:  UITableViewCell.AccessoryType

    init(bird : Bird){
        self.name = bird.comName

        if bird.howMany != nil {
            if bird.howMany! > 5 {
                self.birdsSighted = "More than 5 birds sighted here!"
                self.accessoryType = .detailDisclosureButton
                
            } else {
                self.birdsSighted =  "\(bird.howMany!) birds sighted at \(bird.locName)"
                self.accessoryType = .none
                
            }
        } else {
            self.birdsSighted = "Unknown how many birds where sighted here"
            self.accessoryType = .none
        }
    }
}

