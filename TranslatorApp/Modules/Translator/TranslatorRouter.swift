//
//  TranslatorRouter.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/20.
//

import UIKit

protocol TranslatorRouterProtocol: class {
    var dataStore: TranslatorDS? { get set }
    func presentLanguageListVC(withButtonType buttonType: ButtonType)
}

class TranslatorRouter: TranslatorRouterProtocol {
    weak var viewContoller: TranslatorVC!
    var dataStore: TranslatorDS? ///unused in that case & not need to be initiated
    
    init(viewContoller: TranslatorVC) {
        self.viewContoller = viewContoller
    }
    
    func presentLanguageListVC(withButtonType buttonType: ButtonType) {
        dataStore?.buttonType = buttonType
        let destinationVC = LangListVC()
        let vc = viewContoller!
        vc.present(destinationVC, animated: true, completion: nil)
    }
}

