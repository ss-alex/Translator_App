//
//  HistoryInit.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/20.
//

import UIKit

protocol HistoryInitProtocol {
    func inititialize(vc: HistoryVC)
}

class HistoryInit {
    func inititialize(vc: HistoryVC) {
        let presenter = HistoryPresenter(view: vc)
        let interactor = HistoryInteractor(presenter: presenter)
        let router = HistoryRouter(vc: vc)
        router.dataStore = interactor
        vc.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

