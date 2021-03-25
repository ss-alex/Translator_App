//
//  LanguagesListInteractor.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/20.
//

import UIKit

protocol LangListDS {
    var selectedLanguage: String? { set get }
}

protocol LangListInteractorProtocol: class {
    func listLanguages() -> [Language]
}

class LangListInteractor: LangListInteractorProtocol, LangListDS {
    let networkService: NetworkServiceProtocol = NetworkService()
    weak var presenter: LangListPresenterProtocol!
    var selectedLanguage: String?
    
    func listLanguages() -> [Language] {
        return networkService.supportedLanguages
    }
    
    required init(presenter: LangListPresenterProtocol) {
        self.presenter = presenter
    }
    
    
}
