//
//  CourseViewModel.swift
//  MVCtoMVVM
//
//  Created by M_931521 on 08/03/2022.
//

import Foundation
import UIKit

struct CourseViewModel {
    
    let name: String
    
    let detailTextString: String
    let accessoryType: UITableViewCell.AccessoryType
    
    // Dependency Injection (DI)
    init(course: Course) {
        self.name = course.name
        let number = Int.random(in: 1..<100)
        if course.numberOfLessons > 35 {
            detailTextString = "Lessons 30+ Check it Out!"
            accessoryType = .detailDisclosureButton
        } else {
            detailTextString = "Lessons: \(course.numberOfLessons)"
            accessoryType = .none
        }
    }
    
}
