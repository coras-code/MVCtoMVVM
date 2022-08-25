//
//  AddOrderViewController.swift
//  HotCoffee
//
//  Created by M_931521 on 04/04/2022.
//

import Foundation
import UIKit
import CoreLocation

protocol AddSightingDelegate {
    func didSaveSighting()
}

class AddSightingViewController: UIViewController {
    
    let addSightingViewModel = AddSightingViewModel()
    var delegate: AddSightingDelegate?
    var namePickerView = UIPickerView()
    let locationManager = CLLocationManager()
    var location: CLLocation?
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var numberOfSightingsTextField: UITextField!
    @IBOutlet weak var coordButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        addSightingViewModel.fetchExampleBirdNames() {
            self.spinner.stopAnimating()
        }
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        namePickerView.delegate = self
        namePickerView.dataSource = self
        nameTextField.inputView = namePickerView
    }
    
    func updateCoords() {
      if let location = location {
        latitudeTextField.text = String(format: "%.8f",
                                    location.coordinate.latitude)
        longitudeTextField.text = String(format: "%.8f",
                                     location.coordinate.longitude)
      }
        self.spinner.stopAnimating()
    }
    
    
    //MARK: - IB Actions
    @IBAction func coordButtonPressed(_ sender: UIButton) {
        self.spinner.startAnimating()
        locationManager.requestLocation()
        locationTextField.becomeFirstResponder()
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        
        if let latitude = latitudeTextField.text, let longitude = longitudeTextField.text  {
            spinner.startAnimating()
            addSightingViewModel.convertCoordsToLocation(lat: latitude, lon: longitude) { (locationDetails) in
                self.locationTextField.isEnabled = true
                self.locationTextField.text = locationDetails
                self.spinner.stopAnimating()
                self.numberOfSightingsTextField.becomeFirstResponder() //Indicate to the user its loading
            }
        } else {} //user error - fields are empty
        
    }
    
    @IBAction func save() {
        //make sure that it is not possible for this to be nil, validation/user input errors
        spinner.startAnimating()
        let sighting = Bird(comName: nameTextField.text!, locName: locationTextField.text ?? "Unknown", howMany: Int(numberOfSightingsTextField.text ?? "0") , lat: Double(latitudeTextField.text!) ?? 0, lng: Double(longitudeTextField.text!) ?? 0)
        
        guard let data = try? JSONEncoder().encode(sighting) else {
            fatalError("Error encoding Sighting!")
        }
        
        let sightingResource = Resource<Bird>(httpMethod: "POST", body: data)
        
        //Post to API
        Service.shared.load(resource: sightingResource){ (bird, err) in //pass in default resource
            if let err = err {
            print("Failed to post sighting:", err.localizedDescription)
                self.spinner.stopAnimating()
                return
            }
            
            guard bird != nil else {
                print("Unexpected response returned from server")
                
                self.spinner.stopAnimating()
                return
            }
            
            if let delegate = self.delegate {
                self.dismiss(animated: true, completion: nil)
                delegate.didSaveSighting()
                self.spinner.stopAnimating()
            }
        }
    }
}

//MARK: UI Picker
extension AddSightingViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return addSightingViewModel.exampleBirdNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return addSightingViewModel.exampleBirdNames[row]
    }
}

extension AddSightingViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameTextField.text = addSightingViewModel.exampleBirdNames[row]
        latitudeTextField.becomeFirstResponder()
    }
}

//MARK: - Location
extension AddSightingViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.last != nil {
            location = locations.last
            updateCoords()
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
