//
//  BirdCell.swift
//  MVCtoMVVM
//
//  Created by Cora on 08/03/2022.
//

import Foundation

import UIKit

class BirdCellMVVM: UITableViewCell {
    
    static let identifier = "MVCTableViewCell"
    
    var birdViewModel: BirdViewModelMVVM! {
        didSet {
            textLabel?.text = birdViewModel.name
            detailTextLabel?.text = birdViewModel.detailTextString
            accessoryType = birdViewModel.accessoryType
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        // cell customization
        textLabel?.font = UIFont.systemFont(ofSize: 24)
        textLabel?.numberOfLines = 0 //stops truncating of title
        textLabel?.textColor = .mainTextBlue
        detailTextLabel?.font = UIFont.systemFont(ofSize: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
