//
//  CourseViewModel.swift
//  MVCtoMVVM
//
//  Created by M_931521 on 08/03/2022.
//

import Foundation
import UIKit

struct CourseViewModelMVVM {
    
    let name: String
    
    let detailTextString: String
    let accessoryType: UITableViewCell.AccessoryType
    
    // Dependency Injection (DI)
    init(course: CourseMVVM) {
        self.name = course.name
        if course.numberOfLessons > 35 {
            detailTextString = "Lessons 30+ Check it Out!"
            accessoryType = .detailDisclosureButton
        } else {
            detailTextString = "Lessons: \(course.numberOfLessons)"
            accessoryType = .none
        }
    }
    
}
