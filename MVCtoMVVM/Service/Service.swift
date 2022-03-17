//
//  Service.swift
//  MVCtoMVVM
//
//  Created by M_931521 on 17/03/2022.
//

import Foundation

struct Service {
    static let shared = Service()
    
    func fetchCourses(completion: @escaping ([Course]?, Error?) -> ()) {
        completion(courses, nil)
    }
    
    //look into result types
    //    func fetchCourses(_ completion: @escaping (Result<[Course], Error>) -> ()) {
    //            completion(.success(data)) //result types
    //        }
}

let courses = [
    Course(id: 23, name: "Javascript Course", numberOfLessons: 56),
    Course(id: 43, name: "Swift Course", numberOfLessons: 12),
    Course(id: 56, name: "Python Course", numberOfLessons: 109),
    ]
