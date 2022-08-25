//
//  BirdsController.swift
//  MVCtoMVVM
//
//  Created by Cora on 17/03/2022.
//

import UIKit

class BirdsController: UITableViewController {
    
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

        self.birdsViewModels = birds?.map({return BirdViewModel(bird: $0)}) ?? []
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
        
        return cell
    }
}
