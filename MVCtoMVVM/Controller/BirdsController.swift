//
//  CoursesController.swift
//  MVCtoMVVM
//
//  Created by Cora on 17/03/2022.
//

import UIKit

class CoursesController: UITableViewController { //Info: A subclass of UIViewController, already has the properties and protocols (delegate and datasource that you need to create a tableview)
    
    var birds = [Bird]()
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    fileprivate func fetchData() {
       Service.shared.fetchBirds { (birds, err) in
           if let err = err {
            print("Failed to fetch birds:", err.localizedDescription)
               return
           }

           self.birds = birds ?? [] //Additional Research: do i need ?? []
           self.tableView.reloadData()

       }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let bird = birds[indexPath.row]
        
        cell.textLabel?.text = bird.comName
        if bird.howMany != nil {
            if bird.howMany! > 10 {
                cell.accessoryType = .detailDisclosureButton
                cell.detailTextLabel?.text = "10+ birds sighted here"
            } else {
                cell.detailTextLabel?.text = "\(bird.howMany!) birds sighted at \(bird.locName)"
                cell.accessoryType = .none
            }
        }
        
        cell.selectionStyle = .none
        
        //this does not need to be extracted out as this is to be able to programmatically/create a nib to design a (custom) cell but as we are using a storyboard we dont need to do this
        
        return cell
    }
}
