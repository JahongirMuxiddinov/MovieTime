//
//  AppDelegate.swift
//  MovieTime
//
//  Created by JAHONGIR on 06/09/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        let vc = TabBarController()
//        let nav = UINavigationController(rootViewController: vc)
        
        window?.rootViewController = vc
        
        return true
    }

    
}

