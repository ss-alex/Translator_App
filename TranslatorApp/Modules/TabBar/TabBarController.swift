//
//  TabBarController.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/26.
//

import UIKit

class TabBarController: UITabBarController {
    let translatorVC = TranslatorVC()
    let historyVC = HistoryVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarItems()
    }
    
    private func setupTabBarItems() {
        let itemTranslate = UITabBarItem()
        itemTranslate.title = "Translate"
        itemTranslate.image = UIImage(systemName: "magnifyingglass")
        
        let itemHistory = UITabBarItem()
        itemHistory.title = "History"
        itemHistory.image = UIImage(systemName: "folder")
        
        translatorVC.tabBarItem = itemTranslate
        historyVC.tabBarItem = itemHistory
        
        viewControllers = [translatorVC, historyVC]
    }
}
