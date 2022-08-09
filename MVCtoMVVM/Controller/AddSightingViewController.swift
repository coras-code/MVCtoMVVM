//
//  AddOrderViewController.swift
//  HotCoffee
//
//  Created by M_931521 on 04/04/2022.
//

import Foundation
import UIKit

protocol AddSightingDelegate {
    func didSaveSighting()
    //func didClose()
}

class AddSightingViewController: UIViewController {
    
    var delegate: AddSightingDelegate?
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var numberOfSightings: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: UI
    private func setupUI() {
    }
    
    
    // MARK: Actions
//    @IBAction func close() {
//    }
    
    @IBAction func save() {
        
        let string = "\(nameTextField.text!) \(latitudeTextField.text!) \(longitudeTextField.text!) \(numberOfSightings.text!)"
        print(string)
        
        let sighting = Bird(comName: nameTextField.text!, locName: "", howMany: Int(numberOfSightings.text!), lat: Double(latitudeTextField.text!) ?? 0, lng: Double(longitudeTextField.text!) ?? 0)
        
        guard let data = try? JSONEncoder().encode(sighting) else {
            fatalError("Error encoding Sighting!")
        }
        
        //post this to api
        let sightingResource = Resource<[Bird]>(httpMethod: "POST", body: data)
        Service.shared.loadSightings(resource: sightingResource){ (birds, err) in //pass in default resource
           if let err = err {
            print("Failed to post sighting:", err.localizedDescription)
               return
           }
            
            if let birds = birds {
                if let delegate = self.delegate {
                    delegate.didSaveSighting()
                    self.dismiss(animated: true, completion: nil)
                }
                print(birds)
            }
        }
        
        
    }
}
