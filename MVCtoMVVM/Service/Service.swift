//
//  Service.swift
//  MVCtoMVVM
//
//  Created by Cora on 17/03/2022.
//

import Foundation

//Sightings part of the app
struct Resource<T: Codable> { //generics
    let urlString: String = "https://shining-fantastic-risk.glitch.me/birds"
    var httpMethod: String = "GET" //or "POST"
    var body: Data? = nil
}


struct Service {
    static let shared = Service()
    
    func fetchBirds(completion: @escaping ([Bird]?, Error?) -> ()) {
        let urlString = "https://api.ebird.org/v2/data/obs/GB/recent?key=23589pvbie2n"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch birds:", err)
                return
            }
            
            guard let data = data else { return }
            do {
                let birds = try JSONDecoder().decode([Bird].self, from: data)
                DispatchQueue.main.async {
                    completion(birds, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
            }.resume()
    }
    
    //Sightings part of the app
    func loadSightings<T>(resource: Resource<T>, completion: @escaping ([Bird]?, Error?) -> ()) {
        guard let url = URL(string: resource.urlString) else { fatalError("URL is incorrect") }
        var request = URLRequest(url: url)
        request.httpMethod = resource.httpMethod
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")//add header - indicate that
        
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch birds:", err)
                return
            }
            
            guard let data = data else { return }
            do {
                let birds = try JSONDecoder().decode([Bird].self, from: data)
                DispatchQueue.main.async {
                    completion(birds, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
            }.resume()
    }

    //NO API
//    func fetchCourses(completion: @escaping ([Bird]?, Error?) -> ()) {
//        completion(birds, nil)
//    }
//
//    //look into result types
//    //    func fetchCourses(_ completion: @escaping (Result<[Bird], Error>) -> ()) {
//    //            completion(.success(data)) //result types
//    //        }
//}
//
//    let birds = [
//        Bird(comName: 23, locName: "Javascript Bird", howMany: 56),
//        Bird(comName: 43, locName: "Swift Bird", howMany: 12),
//        Bird(comName: 56, locName: "Python Bird", howMany: 109),
//        ]
}
