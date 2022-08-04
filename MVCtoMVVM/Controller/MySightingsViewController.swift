//
//  MySightingsViewController.swift
//  MVCtoMVVM
//
//  Created by M_931521 on 04/08/2022.
//

import Foundation
import UIKit

class MySightingsViewController: UITableViewController {
    
    let cellId = "MySightingsTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        //return ViewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
//        let sighting = birdsViewModels[indexPath.row]
//
//        cell.textLabel?.text = bird.name
//        cell.accessoryType = bird.accessoryType
//        cell.detailTextLabel?.text = bird.birdsSighted
//
        cell.textLabel?.text = "Hello"
        cell.detailTextLabel?.text = "You"
        cell.selectionStyle = .none
        
        //this does not need to be extracted out as this is to be able to programmatically/create a nib to design a (custom) cell but as we are using a storyboard we dont need to do this
        
        return cell
    }
    
}
