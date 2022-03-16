//
//  CourseCell.swift
//  MVCtoMVVM
//
//  Created by M_931521 on 08/03/2022.
//

import Foundation

import UIKit

class CourseCellMVVM: UITableViewCell {
    
    var courseViewModel: CourseViewModelMVVM! {
        didSet {
            textLabel?.text = courseViewModel.name
            detailTextLabel?.text = courseViewModel.detailTextString
            accessoryType = courseViewModel.accessoryType
        }
    }
    
    //Extra UI design
//    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
//        super.setHighlighted(highlighted, animated: animated)
//        contentView.backgroundColor = isHighlighted ? .highlightColor : .white
//        textLabel?.textColor = isHighlighted ? UIColor.white : .mainTextBlue
//        detailTextLabel?.textColor = isHighlighted ? .white : .black
//    }
//
//
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        // cell customization
                textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
                textLabel?.numberOfLines = 0
                detailTextLabel?.textColor = .black
                detailTextLabel?.font = UIFont.systemFont(ofSize: 20, weight: .light)
           
    }
        

    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
