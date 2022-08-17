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
}

class AddSightingViewController: UIViewController {
    
    var delegate: AddSightingDelegate?
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var numberOfSightings: UITextField!
    var namePickerView = UIPickerView()
    var birdNames = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Hack - list of offical bird names using anotehr api
        Service.shared.fetchBirds{(birds, err) in
            if let birds = birds {
                self.birdNames = birds.map({return $0.comName}).sorted(by: <)
                self.namePickerView.reloadAllComponents()
            }
        }
        setupUI()
    }
    
    // MARK: UI
    private func setupUI() {
        namePickerView.delegate = self
        namePickerView.dataSource = self
        nameTextField.inputView = namePickerView
    }
    
    @IBAction func save() {
        
        let sighting = Bird(comName: nameTextField.text!, locName: "", howMany: Int(numberOfSightings.text!), lat: Double(latitudeTextField.text!) ?? 0, lng: Double(longitudeTextField.text!) ?? 0)
        
        guard let data = try? JSONEncoder().encode(sighting) else {
            fatalError("Error encoding Sighting!")
        }
        
        //post this to api
        let sightingResource = Resource<Bird>(httpMethod: "POST", body: data)
        Service.shared.loadSightings(resource: sightingResource){ (bird, err) in //pass in default resource
            if let err = err {
            print("Failed to post sighting:", err.localizedDescription)
               return
            }
            
            guard bird != nil else {
                print("Unexpected response returned from server")
                return
            }
            
            if let delegate = self.delegate {
                self.dismiss(animated: true, completion: nil)
                delegate.didSaveSighting()
            }
        }
    }
}

extension AddSightingViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return birdNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if birdNames.count > 1 {
            return birdNames[row]
        } else {
            return ""
        }
    }
}

extension AddSightingViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameTextField.text = birdNames[row]
       // nameTextField.resignFirstResponder() //don't know if i like this behaviour
    }
}

