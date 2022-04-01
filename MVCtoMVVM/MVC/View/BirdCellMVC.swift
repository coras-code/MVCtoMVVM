//
//  BirdCell.swift
//  MVCtoMVVM
//
//  Created by Cora on 08/03/2022.
//

import Foundation

import UIKit
import Foundation

class BirdCellMVC: UITableViewCell {
    var bird: BirdMVC! {
            didSet {
                
                textLabel?.text = bird.comName
                if bird.howMany != nil {
                    if bird.howMany! > 10 {
                        accessoryType = .detailDisclosureButton
                        detailTextLabel?.text = "10+ birds sighted here"
                    } else {
                        detailTextLabel?.text = "\(bird.howMany!) birds sighted at \(bird.locName)"
                        accessoryType = .none
                    }
                }
            }
        }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        //Cell customization
        textLabel?.textColor = .mainTextBlue
        textLabel?.font = UIFont.systemFont(ofSize: 24)
        textLabel?.numberOfLines = 0 //stops truncating of the title
        detailTextLabel?.font = UIFont.systemFont(ofSize: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
