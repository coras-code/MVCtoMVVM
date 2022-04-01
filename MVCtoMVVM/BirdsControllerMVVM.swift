//
//  BirdsControllerMVVM.swift
//  MVCtoMVVM
//
//  Created by M_931521 on 08/03/2022.
//

import Foundation
import UIKit

class BirdsControllerMVVM: UITableViewController {
  
    //before
    //var birdViewModels: [BirdViewModel] = [] array of viewModels
    var birdModels: [BirdMVVM] = [] //array of bird models (just as the web service returns it)
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
        fetchData()
    }
    
    fileprivate func fetchData() {
        Service.shared.fetchBirdsMVVM { (birds, err) in
            if let err = err {
                print("Failed to fetch birds:", err)
                return
            }
            

            //before //converts (bird) models into view models
            //self.birdViewModels = birds?.map({return BirdViewModel(bird: $0)}) ?? []
            if let birds = birds {
                self.birdModels = birds //don't bother converting
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birdModels.count //return birdViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BirdCellMVVM

//        before:
//        let birdViewModel = birdViewModels[indexPath.row]
//        cell.birdViewModel = birdViewModel
        cell.birdViewModel = BirdViewModelMVVM(bird: birdModels[indexPath.row]) //convert model into viewModel here
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    fileprivate func setupTableView() {
        tableView.register(BirdCellMVVM.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = .mainTextBlue
    }

    fileprivate func setupNavBar() {
        navigationItem.title = "Birds"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

extension UIColor {
    static let mainTextBlue = UIColor.rgb(r: 7, g: 71, b: 89)
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

