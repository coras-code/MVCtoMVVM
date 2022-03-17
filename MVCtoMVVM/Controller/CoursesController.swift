//
//  CoursesController.swift
//  MVCtoMVVM
//
//  Created by M_931521 on 17/03/2022.
//

import UIKit

class CoursesController: UITableViewController { //Info: A subclass of UIViewController, already has the properties and protocols (delegate and datasource that you need to create a tableview)
    
    var courses = [Course]()
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    fileprivate func fetchData() {
       Service.shared.fetchCourses { (courses, err) in
           if let err = err {
            print("Failed to fetch courses:", err.localizedDescription)
               return
           }

           self.courses = courses ?? [] //Additional Research: do i need ?? []
           self.tableView.reloadData()

       }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let course = courses[indexPath.row]
        
        cell.textLabel?.text = course.name
            
        if course.numberOfLessons > 35 {
            cell.accessoryType = .detailDisclosureButton
            cell.detailTextLabel?.text = "Lessons 30+ Check it Out"
        } else {
            cell.detailTextLabel?.text = "Lessons: \(course.numberOfLessons)"
            cell.accessoryType = .none
        }
        
        cell.selectionStyle = .none
        
        //this does not need to be extracted out as this is to be able to programmatically/create a nib to design a (custom) cell but as we are using a storyboard we dont need to do this
        
        return cell
    }
}
