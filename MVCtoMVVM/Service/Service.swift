//
//  Service.swift
//  MVCtoMVVM
//
//  Created by Cora on 08/03/2022.
//

import Foundation

struct Service {
    static let shared = Service()
    
    func fetchBirdsMVVM(completion: @escaping ([BirdMVVM]?, Error?) -> ()) {
        let urlString = "https://api.ebird.org/v2/data/obs/GB/recent?key=23589pvbie2n"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch birds:", err)
                return
            }
            
            // check response
            
            guard let data = data else { return }
            do {
                let birds = try JSONDecoder().decode([BirdMVVM].self, from: data)
                DispatchQueue.main.async {
                    completion(birds, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
        }.resume()
    }
    
    func fetchBirdsMVC(completion: @escaping ([BirdMVC]?, Error?) -> ()) {
           let urlString = "https://api.ebird.org/v2/data/obs/GB/recent?key=23589pvbie2n"
           guard let url = URL(string: urlString) else { return }
           
            URLSession.shared.dataTask(with: url) { (data, resp, err) in
               if let err = err {
                   completion(nil, err)
                   print("Failed to fetch birds:", err)
                   return
               }
               
               // check response
               
               guard let data = data else { return }
               do {
                   let birds = try JSONDecoder().decode([BirdMVC].self, from: data)
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
