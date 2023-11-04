//
//  TabBarController.swift
//  MovieTime
//
//  Created by JAHONGIR on 09/09/23.
//

import Foundation
import UIKit


class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
            
        let home = HomePageVC(nibName: "HomePageVC", bundle: nil)
        let navHome = UINavigationController(rootViewController: home)
        home.title = "Home"
        home.tabBarItem.image = UIImage(systemName: "house")
        
        let upComing = UpcomingVC(nibName: "UpcomingVC", bundle: nil)
        let navUpcoming = UINavigationController(rootViewController: upComing)
        upComing.title = "Upcoming"
        upComing.tabBarItem.image = UIImage(systemName: "play.circle")
        
        let search = SearchVC(nibName: "SearchVC", bundle: nil)
        let navSearch = UINavigationController(rootViewController: search)
        search.title = "Search"
        search.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        tabBar.backgroundColor = .systemGray4
        tabBar.tintColor = .black
        
        self.setViewControllers([navHome, navUpcoming, navSearch], animated: true)
        
    }
}
