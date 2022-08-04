//
//  BirdsController.swift
//  MVCtoMVVM
//
//  Created by Cora on 17/03/2022.
//

import UIKit

class BirdsController: UITableViewController { //Info: A subclass of UIViewController, already has the properties and protocols (delegate and datasource that you need to create a tableview)
    
    var birdsViewModels = [BirdViewModel]()
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func fetchData() {
       Service.shared.fetchBirds { (birds, err) in
           if let err = err {
            print("Failed to fetch birds:", err.localizedDescription)
               return
           }

        self.birdsViewModels = birds?.map({return BirdViewModel(bird: $0)}) ?? [] //Additional Research: do i need ?? []
           self.tableView.reloadData()

       }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birdsViewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let bird = birdsViewModels[indexPath.row]
        
        cell.textLabel?.text = bird.name
        cell.accessoryType = bird.accessoryType
        cell.detailTextLabel?.text = bird.birdsSighted
    
        cell.selectionStyle = .none
        
        //this does not need to be extracted out as this is to be able to programmatically/create a nib to design a (custom) cell but as we are using a storyboard we dont need to do this
        
        return cell
    }
}
