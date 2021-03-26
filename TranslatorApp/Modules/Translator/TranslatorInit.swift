//
//  TranslatorInitializer.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/20.
//

import UIKit

protocol TranslatorInitProtocol: class {
    func initialize(vc: TranslatorVC)
}

class TranslatorInit: TranslatorInitProtocol {
    
    func initialize(vc: TranslatorVC) {
        let presenter = TranslatorPresenter(view: vc)
        let interactor = TranslatorInteractor(presenter: presenter)
        let router = TranslatorRouter(viewContoller: vc)
        router.dataStore = interactor
        vc.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
