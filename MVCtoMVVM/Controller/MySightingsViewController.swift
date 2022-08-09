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
        
        Service.shared.loadSightings(resource: Resource<[Bird]>()){ (birds, err) in //pass in default resource
           if let err = err {
            print("Failed to fetch birds:", err.localizedDescription)
               return
           }

        self.sightings = birds!
        print(self.sightings)
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
        let details = "You spotted \(sighting.howMany!) birds at \(sighting.lat)°, \(sighting.lng)°"
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
//        if segue.identifier == "AddWeatherCityViewController" {
////        guard let navC = segue.destination as? UINavigationController,
////              let addSightingVC = navC.viewControllers.first as? AddSightingViewController
////        else {
////            fatalError("Error performing segue!")
////        }
//        addSightingVC.delegate = self
//    }
}


//if segue.identifier == "AddWeatherCityViewController" {
//           guard let nav = segue.destination as? UINavigationController else {
//               fatalError("NavigationController not found")
//           }
//
//           guard let addWeatherCityVC = nav.viewControllers.first as? AddWeatherCityViewController else {
//               fatalError("AddWeatherCityController not found")
//           }
//
//               addWeatherCityVC.delegate = self
