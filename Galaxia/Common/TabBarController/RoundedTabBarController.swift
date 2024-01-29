//
//  RoundedTabBar.swift
//  Galaxia
//
//  Created by Mushfiq Humayoon on 28/01/24.
//

import UIKit

class RoundedTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setValue(RoundedTabBar(), forKey: "tabBar")
        selectedIndex = 0
        if let tabBarItems = tabBar.items {
            tabBarItems[0].image = .homeOutlined
            tabBarItems[0].selectedImage = .homeFilled
            tabBarItems[2].image = .heartOutlined
            tabBarItems[2].selectedImage = .heartFilled
        }
        tabBar.tintColor = UIColor.white
        tabBar.unselectedItemTintColor = UIColor.gray
    }
}
