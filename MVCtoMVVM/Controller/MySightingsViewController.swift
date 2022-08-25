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
    var sightings = [Bird]()
    var sightingsViewModels = [MySightingsViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        populateSightings()
    }
    
    fileprivate func populateSightings() {
        Service.shared.load(resource: Resource<[Bird]>()){ (birds, err) in
           if let err = err {
            print("Failed to fetch birds:", err.localizedDescription)
               return
           }
            
            self.sightingsViewModels = birds!.map({ MySightingsViewModel($0)
            }).reversed()

            self.tableView.reloadData()
       }
    }
    
    //MARK: TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sightingsViewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let sighting = sightingsViewModels[indexPath.row]
        cell.textLabel?.text = sighting.name
        cell.detailTextLabel?.text = sighting.details
        
        return cell
    }
}

extension MySightingsViewController: AddSightingDelegate {
    func didSaveSighting() {
        populateSightings() //refresh sightings with new one
    }
}

// MARK: Navigation
extension MySightingsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddSightingViewController" {
            let addSightingVC = segue.destination as! AddSightingViewController
            addSightingVC.delegate = self
        }
    }
}
