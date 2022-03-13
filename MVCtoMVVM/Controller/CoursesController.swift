//
//  CoursesController.swift
//  MVCtoMVVM
//
//  Created by M_931521 on 08/03/2022.
//

import Foundation
import UIKit

class CoursesController: UITableViewController {

    var courses = [Course]()
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupTableView()
        fetchData()
    }

    fileprivate func fetchData() {
        Service.shared.fetchCourses { (courses, err) in
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }

            self.courses = courses ?? []
            self.tableView.reloadData()


        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CourseCell
        let course = courses[indexPath.row]
        cell.course = course //unsure


        return cell
    }

    fileprivate func setupTableView() {
        tableView.register(CourseCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        tableView.separatorColor = .mainTextBlue
        tableView.backgroundColor = UIColor.rgb(r: 12, g: 47, b: 57)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.tableFooterView = UIView()
    }

    fileprivate func setupNavBar() {
        navigationItem.title = "Courses"
        navigationController?.navigationBar.prefersLargeTitles = true
        //navigationController?.navigationBar.backgroundColor = .yellow
        navigationController?.navigationBar.isTranslucent = false
       // navigationController?.navigationBar.barTintColor = UIColor.rgb(r: 50, g: 199, b: 242)
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }

}

class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UIColor {
    static let mainTextBlue = UIColor.rgb(r: 7, g: 71, b: 89)
    static let highlightColor = UIColor.rgb(r: 50, g: 199, b: 242)

    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

//
//  Service.swift
//  MVCtoMVVM
//
//  Created by M_931521 on 08/03/2022.
//

//import Foundation
//
//struct Service {
//    static let shared = Service()
//    
//    func fetchCourses(completion: @escaping ([Course]?, Error?) -> ()) {
//        completion(courses, nil)
//    }
//    
//    //    func fetchCourses(_ completion: @escaping (Result<[Course], Error>) -> ()) { //look into result types
//    //            completion(.success(data)) //result types
//    //        }
//}
//
//let courses = [
//    Course(id: 23, name: "Javascript Course", numberOfLessons: 56),
//    Course(id: 43, name: "Swift Course", numberOfLessons: 12),
//    Course(id: 56, name: "Python Course", numberOfLessons: 109),
//    ]
//
//
//
//
//
//
//
//
//
//
//
//
//
//
////class Service: NSObject {
////    static let shared = Service()
////
////    func fetchCourses(completion: @escaping ([Course]?, Error?) -> ()) {
////        let urlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
////        guard let url = URL(string: urlString) else { return }
////        URLSession.shared.dataTask(with: url) { (data, resp, err) in
////            if let err = err {
////                completion(nil, err)
////                print("Failed to fetch courses:", err)
////                return
////            }
////
////            // check response
////
////            guard let data = data else { return }
////            do {
////                let courses = try JSONDecoder().decode([Course].self, from: data)
////                DispatchQueue.main.async {
////                    completion(courses, nil)
////                }
////            } catch let jsonErr {
////                print("Failed to decode:", jsonErr)
////            }
////            }.resume()
////    }
////}
//
