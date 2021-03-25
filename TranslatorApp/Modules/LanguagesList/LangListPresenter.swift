//
//  LanguagesListPresenter.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/20.
//

import UIKit

protocol LangListPresenterProtocol: class {
    var router: LangListRouterProtocol? { get set }
    var languageNames: [String] { get set }
    func configureView()
    var selectedLanguage: String { get set }
}

class LangListPresenter: LangListPresenterProtocol {
    
    var selectedLanguage: String = "" {
        didSet {
            router?.dataStore?.selectedLanguage = selectedLanguage
        }
    }
 
    var languageNames = [String]() {
        didSet {
            view.reloadData()
        }
    }
    
    weak var view: LangListViewProtocol!
    var interactor: LangListInteractorProtocol!
    var router: LangListRouterProtocol?
    
    required init(view: LangListViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        let languages = interactor.listLanguages()
        
        for i in languages {
            languageNames.append(i.name)
        }
    }
}
