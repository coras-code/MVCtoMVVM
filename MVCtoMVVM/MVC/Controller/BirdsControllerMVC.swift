//
//  BirdsControllerMVC.swift
//  MVCtoMVVM
//
//  Created by Cora on 08/03/2022.
//

import Foundation
import UIKit

class BirdsControllerMVC: UITableViewController {

    var birds = [BirdMVC]()
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
        fetchData()
    }

    fileprivate func fetchData() {
        Service.shared.fetchBirdsMVC { (birds, err) in
            if let err = err {
                print("Failed to fetch birds:", err)
                return
            }

            self.birds = birds ?? []
            self.tableView.reloadData()

        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BirdCellMVC
        let bird = birds[indexPath.row]
        cell.bird = bird
        
        cell.selectionStyle = .none

        return cell
    }

    fileprivate func setupTableView() {
        tableView.register(BirdCellMVC.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = .mainTextBlue
    }

    fileprivate func setupNavBar() {
        navigationItem.title = "Birds MVC"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

//in MVVM files dont need to repeat it 
//extension UIColor {
    //static let mainTextBlue = UIColor(red: 7/255, green: 71/255, blue: 89/255, alpha: 1)
//}


