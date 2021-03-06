//
//  LanguagesListIntializer.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/20.
//

import UIKit

protocol LangListInitProtocol: class {
    func initialize(viewController: LangListVC)
}

class LangListInit: LangListInitProtocol {
    
    func initialize(viewController: LangListVC) {
        let presenter = LangListPresenter(view: viewController)
        let interactor = LangListInteractor(presenter: presenter)
        let router = LangListRouter(viewController: viewController)
        router.dataStore = interactor
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
