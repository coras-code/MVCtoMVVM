//
//  AddSightingsViewModel.swift
//  MVCtoMVVM
//
//  Created by M_931521 on 25/08/2022.
//

import Foundation

class AddSightingViewModel {
    
    
    var exampleBirdNames = [String]()
    //MOVE TO CORE DATA
    //Hack - list of offical bird names using another api
    func fetchExampleBirdNames(completion: @escaping () -> ()) {
        Service.shared.fetchBirds{(birds, err) in
            if let birds = birds {
                self.exampleBirdNames = birds.map({return $0.comName}).sorted(by: <)
                completion()
            }
        }
    }
    
    func convertCoordsToLocation(lat: String, lon: String, completion: @escaping (String) -> () ) {
        let urlString = "https://api.geoapify.com/v1/geocode/reverse?lat=\(lat)&lon=\(lon)&apiKey=d8f17f25925a470ab4e3247cd84167fa"
            
        let geoCodingResource = Resource<LocationData>(urlString: urlString)
        
        Service.shared.load(resource: geoCodingResource) { (location, err) in
            if let err = err {
             print("Failed to figure out location:", err.localizedDescription)
                return
            }
            
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
                
                completion(locationDetails.joined(separator: " "))
            }
        }
    }
}
