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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        populateSightings()
    }
    
    fileprivate func populateSightings() {
        //pass in default resource
        Service.shared.load(resource: Resource<[Bird]>()){ (birds, err) in
           if let err = err {
            print("Failed to fetch birds:", err.localizedDescription)
               return
           }

            self.sightings = birds!.reversed()
            self.tableView.reloadData()
       }
    }
    
    //MARK: TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sightings.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let sighting = sightings[indexPath.row]
        cell.textLabel?.text = sighting.comName
        var latitude = "\(sighting.lat)° N"
        var longitude = "\(sighting.lng)° E"
        
        if sighting.lat < 0 {
            latitude = "\(sighting.lat)° S"
        }
        if sighting.lng < 0 {
            longitude = "\(sighting.lng)° W"
        }
        let details = "You spotted \(sighting.howMany ?? 0) birds at \(sighting.locName), (\(latitude), \(longitude))"
        cell.detailTextLabel?.text = details
        
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
