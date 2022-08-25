//
//  MySightingsViewModel.swift
//  MVCtoMVVM
//
//  Created by M_931521 on 23/08/2022.
//

import Foundation

struct MySightingsViewModel {
    
    let sighting: Bird
    
    init(_ bird : Bird) {
        self.sighting = bird
    }
    
    var name: String {
        return sighting.comName
    }
    
    var locationName: String {
        return sighting.locName
    }
    
    var locationCoordinates: (lat: Double, lon: Double) {
        return (sighting.lat, sighting.lng)
    }
    
    var numberOfSightings: Int {
        //My server does not accept or return nil values (unlike the other server used in this app)
        guard let howMany = sighting.howMany else {fatalError("No nil values stored in server")}
        return howMany
    }
    
    var latitudeString: String {
        let lat = locationCoordinates.lat
            switch lat {
            case ...0 :
                return "\(lat)° S"
            default:
                return "\(lat)° N"
            }
    }
    
    var longitudeString: String {
        let lon = locationCoordinates.lon
            switch lon {
            case ...0 :
                return "\(lon)° E"
            default:
                return "\(lon)° W"
            }
    }
    
    var details: String {
        return "You spotted \(numberOfSightings) \(name) birds at \(locationName), (\(latitudeString), \(longitudeString))"
    }
}
