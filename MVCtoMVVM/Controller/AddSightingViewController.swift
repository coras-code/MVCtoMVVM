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
    
    let locationManager = CLLocationManager()
    var delegate: AddSightingDelegate?
    var birdNames = [String]()
    var namePickerView = UIPickerView()
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var numberOfSightingsTextField: UITextField!
    @IBOutlet weak var coordButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MOVE TO CORE DATA
        //Hack - list of offical bird names using another api
        Service.shared.fetchBirds{(birds, err) in
            if let birds = birds {
                self.birdNames = birds.map({return $0.comName}).sorted(by: <)
                self.namePickerView.reloadAllComponents()
            }
        }
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        namePickerView.delegate = self
        namePickerView.dataSource = self
        nameTextField.inputView = namePickerView
    }
    
    
    //MARK: - IB Actions
    @IBAction func coordButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
        locationTextField.becomeFirstResponder()
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        convertCoordsToLocation()
        numberOfSightingsTextField.becomeFirstResponder()
    }
    
    @IBAction func save() {
        //make sure that it is not possible for this to be nil, validation/user input errors
        let sighting = Bird(comName: nameTextField.text!, locName: locationTextField.text ?? "Unknown", howMany: Int(numberOfSightingsTextField.text!), lat: Double(latitudeTextField.text!) ?? 0, lng: Double(longitudeTextField.text!) ?? 0)
        
        guard let data = try? JSONEncoder().encode(sighting) else {
            fatalError("Error encoding Sighting!")
        }
        
        let sightingResource = Resource<Bird>(httpMethod: "POST", body: data)
        
        //Post to API
        Service.shared.load(resource: sightingResource){ (bird, err) in //pass in default resource
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

//MARK: UI Picker
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
        latitudeTextField.becomeFirstResponder()
       // nameTextField.resignFirstResponder() //don't know if i like this behaviour
    }
}

//MARK: - Location
extension AddSightingViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            latitudeTextField.text = String(format: "%.10f", latitude)
            longitudeTextField.text = String(format: "%.10f", longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func convertCoordsToLocation() {
        if latitudeTextField.text != nil && longitudeTextField.text != nil  {
            let latitude = latitudeTextField.text
            let longitude = longitudeTextField.text
        
        let urlString = "https://api.geoapify.com/v1/geocode/reverse?lat=\(latitude!)&lon=\(longitude!)&apiKey=d8f17f25925a470ab4e3247cd84167fa"
            
        let geoCodingResource = Resource<LocationData>(urlString: urlString)

            Service.shared.load(resource: geoCodingResource){ (location, err) in
                if let err = err {
                 print("Failed to figure out location:", err.localizedDescription)
                    return
                }

                    self.locationTextField.isEnabled = true
                    var locationDetails = [String]()
                    
                    if let location = location?.features[0].properties {
                        if let housenumber = location.housenumber {
                            locationDetails.append(housenumber)
                        }
                        
                        if let name = location.name {
                            locationDetails.append(name)
                        }
                        
                        if let country = location.country {
                            locationDetails.append(country)
                        }
                    }

                    self.locationTextField.text = locationDetails.joined(separator: " ")
                }
            }
        }

    }


//MARK: - Valdiation and user feedback

// guard let latitude = latitudeTextField.text, let longitude = longitudeTextField.text else { return }

//need to prevent letters being entered then convert to a double and carry out checks
    //Double(latitudeTextField.text!), let longitude = Double(longitudeTextField.text!) else { return }

//        if (-90...90 ~= latitude) || (-180...180 ~= longitude) {
//
//        } else {
//            // create the alert
//                    let alert = UIAlertController(title: "My Title", message: "This is my message.", preferredStyle: UIAlertController.Style.alert)
//
//                    // add an action (button)
//                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//
//                    // show the alert
//                    self.present(alert, animated: true, completion: nil)
//
//        }
