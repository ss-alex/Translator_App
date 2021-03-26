//
//  TranslatorInteractor.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/20.
//

import UIKit

enum ButtonType {
    case left
    case right
    case noType
}

protocol TranslatorDS {
    var leftLanguage: String { get set }
    var rightLanguage: String { get set }
    var buttonType: ButtonType { get set }
    var translation: Translation? { get set }
}

protocol TranslatorInteractorProtocol: class {
    var leftLanguage: String { get set }
    var rightLanguage: String { get set }
    func translate(text: String, fromLang: String, toLang: String)
    func getLanguage(by name: String) -> Language?
}

class TranslatorInteractor: TranslatorInteractorProtocol, TranslatorDS {
    var translation: Translation?
    var leftLanguage: String
    var rightLanguage: String
    var buttonType: ButtonType = .noType /// заглушка
    
    weak var presenter: TranslatorPresenterProtocol!
    let languageService: LanguageServiceProtocol = LanguageService()
    let networkService: NetworkServiceProtocol = NetworkService()
    let storageSerivce: StorageServiceProtocol = StorageService()
    
    required init(presenter: TranslatorPresenter) {
        self.presenter = presenter
        leftLanguage = languageService.leftLanguage.name
        rightLanguage = languageService.rightLanguage.name
    }
    
    func translate(text: String, fromLang: String, toLang: String) {
        presenter.showLoaderView()
        networkService.translate(text: text, fromLang: fromLang, toLang: toLang) { [weak self] (response, error) in
            if error != nil {
                self?.presenter.hideLoaderView()
                self?.presenter.showAlertView(text: Errors.networkError)
            } else {
                guard let translatedText = response?.translations[0].translation as String? else {
                    self?.presenter.showAlertView(text: Errors.responseError)
                    return
                }
                self?.presenter.hideLoaderView()
                self?.storageSerivce.add(translation: Translation(input: text,
                                                                  translation: translatedText))
                self?.presenter.populateOutputLabel(text: translatedText)
            }
        }
    }
    
    func getLanguage(by name: String) -> Language? {
        let languages = networkService.supportedLanguages
        let result = languages.filter { $0.name == name }
        return result.first
    }
}
