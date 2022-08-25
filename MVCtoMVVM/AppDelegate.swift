//
//  AppDelegate.swift
//  MVCtoMVVM
//
//  Created by Cora on 17/03/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13.0, *) {
                  //customNavBarAppearance()
                  let newNavBarAppearance = customNavBarAppearance()
                  let appearance = UINavigationBar.appearance()
                  appearance.scrollEdgeAppearance = newNavBarAppearance
                  appearance.compactAppearance = newNavBarAppearance
                  appearance.standardAppearance = newNavBarAppearance
                  if #available(iOS 15.0, *) { //doesnt work with my xcode
                      appearance.compactScrollEdgeAppearance = newNavBarAppearance
                  }
              } else {
                  UINavigationBar.appearance().barTintColor = UIColor(displayP3Red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
                  UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                  UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                  UIBarButtonItem.appearance().tintColor = UIColor.white
              }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    @available(iOS 13.0, *)
        func customNavBarAppearance() -> UINavigationBarAppearance {
            
            let customNavBarAppearance = UINavigationBarAppearance()
            
            // Apply a background.
            customNavBarAppearance.configureWithOpaqueBackground()
            customNavBarAppearance.backgroundColor = UIColor(named: "mainTextBlue")
            customNavBarAppearance.shadowColor = .clear
            
            // Apply white colored normal and large titles.
            customNavBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            customNavBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            
            let barButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)
            barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
            // Apply white color to all the nav bar buttons.
            barButtonItemAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.lightText]
            barButtonItemAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.label]
            barButtonItemAppearance.focused.titleTextAttributes = [.foregroundColor: UIColor.white]
        
            customNavBarAppearance.backButtonAppearance = barButtonItemAppearance
            customNavBarAppearance.doneButtonAppearance = barButtonItemAppearance
            customNavBarAppearance.buttonAppearance = barButtonItemAppearance
            
            return customNavBarAppearance
        }




}

