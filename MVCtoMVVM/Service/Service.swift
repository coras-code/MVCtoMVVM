//
//  Service.swift
//  MVCtoMVVM
//
//  Created by M_931521 on 08/03/2022.
//

import Foundation

class Service: NSObject {
    static let shared = Service()
    
    func fetchCoursesMVC(completion: @escaping ([CourseMVC]?, Error?) -> ()) {
        let urlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch courses:", err)
                return
            }
            
            // check response
            
            guard let data = data else { return }
            do {
                let courses = try JSONDecoder().decode([CourseMVC].self, from: data)
                DispatchQueue.main.async {
                    completion(courses, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
            }.resume()
    }
    
    func fetchCoursesMVVM(completion: @escaping ([CourseMVVM]?, Error?) -> ()) {
           let urlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
           guard let url = URL(string: urlString) else { return }
           URLSession.shared.dataTask(with: url) { (data, resp, err) in
               if let err = err {
                   completion(nil, err)
                   print("Failed to fetch courses:", err)
                   return
               }
               
               // check response
               
               guard let data = data else { return }
               do {
                   let courses = try JSONDecoder().decode([CourseMVVM].self, from: data)
                   DispatchQueue.main.async {
                       completion(courses, nil)
                   }
               } catch let jsonErr {
                   print("Failed to decode:", jsonErr)
               }
               }.resume()
       }
}

