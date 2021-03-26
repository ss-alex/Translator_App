//
//  HistoryRouter.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/20.
//

import UIKit

protocol HistoryRouterProtocol: class {
    var dataStore: HistoryDS? { get set }
    func moveToTranslatorVC()
}

class HistoryRouter: HistoryRouterProtocol {
    weak var vc: HistoryVC!
    var dataStore: HistoryDS?
    
    init(vc: HistoryVC) {
        self.vc = vc
    }
    
    func moveToTranslatorVC() {
        guard let tab = vc.tabBarController,
            let destVC = tab.viewControllers?.first as? TranslatorVC,
            var destDS = destVC.presenter?.router?.dataStore,
            let ds = dataStore else {
            return
        }
        
        passDataToTranslatorDS(dataStore: ds, dest: &destDS)
        tab.selectedIndex = 0
    }
    
    func passDataToTranslatorDS(dataStore: HistoryDS, dest: inout TranslatorDS) {
        dest.translation = dataStore.translation
    }
}
