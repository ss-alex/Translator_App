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
        itemTranslate.title = TabBarTitles.translate
        itemTranslate.image = Images.translate
        
        let itemHistory = UITabBarItem()
        itemHistory.title = TabBarTitles.history
        itemHistory.image = Images.history
        
        translatorVC.tabBarItem = itemTranslate
        historyVC.tabBarItem = itemHistory
        viewControllers = [translatorVC, historyVC]
        setupDefaultStyle()
    }
    
    private func setupDefaultStyle() {
        UITabBar.appearance().tintColor = .label
    }
}
