//
//  LanguagesListRouter.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/20.
//

import UIKit


protocol LangListRouterProtocol: class {
    var dataStore: LangListDS? { get set }
    func routeToTranslatorVC()
}

class LangListRouter: LangListRouterProtocol {
    var dataStore: LangListDS?
    weak var vc: LangListVC!
    
    required init(viewController: LangListVC) {
        self.vc = viewController
    }
    
    func routeToTranslatorVC() {
        
        guard let tab = vc.presentingViewController as? UITabBarController else {
            return
        }
        
        guard let destinationVC = tab.viewControllers?.first as? TranslatorVC else {
            return
        }
        
        guard var destinationDataStore = destinationVC.presenter.router.dataStore else {
            return
        }
        
        guard let dataStore = self.dataStore else {
            return
        }
        passDataToTranslatorVC(dataStore: dataStore, buttonType: &destinationDataStore)
       
        vc.dismiss(animated: true) {
            destinationVC.presenter.updateLanguages()
        }
    }
    
    func customInitForView() {
        
    }
    
    func passDataToTranslatorVC(dataStore: LangListDS, buttonType: inout TranslatorDS) {
        guard let language = dataStore.selectedLanguage else {
            return
        }
        
        switch buttonType.buttonType {
        case .left:
            buttonType.leftLanguage = language
        case .right:
            buttonType.rightLanguage = language
        case .noType:
            break
        }
    }
}

extension UIViewController {
    var top: UIViewController? {
        if let controller = self as? UINavigationController {
            return controller.topViewController?.top
        }
        if let controller = self as? UISplitViewController {
            return controller.viewControllers.last?.top
        }
        if let controller = self as? UITabBarController {
            return controller.selectedViewController?.top
        }
        if let controller = presentedViewController {
            return controller.top
        }
        return self
    }
}
