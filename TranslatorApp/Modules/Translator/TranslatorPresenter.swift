//
//  TranslatorPresenter.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/20.
//

import UIKit

protocol TranslatorPresenterProtocol: class {
    var router: TranslatorRouterProtocol! { get set }
    
    func configureTranslatorVC()
    func updateLanguages()
    func swapLanguages()
    
    func translate(text: String)
    func populateOutputLabel(text: String)
    
    func showLoaderView()
    func hideLoaderView()
    func showAlertView(text: String)
    func populateViewWhenAppear()
}

class TranslatorPresenter: TranslatorPresenterProtocol {
    
    var leftLanguage: String = ""
    var rightLanguage: String = ""
    
    var interactor: TranslatorInteractorProtocol!
    weak var view: TranslatorViewProtocol!
    var router: TranslatorRouterProtocol!
    
    required init(view: TranslatorViewProtocol) {
        self.view = view
    }
    
    func configureTranslatorVC() {
        leftLanguage = interactor.leftLanguage
        rightLanguage = interactor.rightLanguage
        view.pupulateOutputLabel(text: "")
    }
    
    func populateViewWhenAppear() {
        guard let translation = router.dataStore?.translation else {
            return
        }
        
        let input = translation.input
        let output = translation.translation
        populateInputTF(text: input)
        populateOutputLabel(text: output)
        router.dataStore?.translation = nil
    }
    
    func updateLanguages() {
        if let leftLang = router.dataStore?.leftLanguage,
           let rightLang = router.dataStore?.rightLanguage {
            leftLanguage = leftLang
            rightLanguage = rightLang
        } else {
            leftLanguage = interactor.leftLanguage
            rightLanguage = interactor.rightLanguage
        }
        
        view.setLeftButton(title: leftLanguage)
        view.setRightButton(title: rightLanguage)
    }
    
    func swapLanguages() {
        if let leftLang = router.dataStore?.leftLanguage,
           let rightLang = router.dataStore?.rightLanguage {
            router.dataStore?.leftLanguage = rightLang
            router.dataStore?.rightLanguage = leftLang
        } else {
            let leftLang = interactor.leftLanguage
            let righLang = interactor.rightLanguage
            interactor.leftLanguage = righLang
            interactor.rightLanguage = leftLang
        }
        updateLanguages()
    }
    
    func translate(text: String) {
        let fromLang = (interactor.getLanguage(by: leftLanguage)?.code)!
        let toLang = (interactor.getLanguage(by: rightLanguage)?.code)!
        interactor.translate(text: text, fromLang: fromLang, toLang: toLang)
    }
    
    func populateInputTF(text: String) { // метод 1
        view.populateInputTF(text: text)
    }
    
    func populateOutputLabel(text: String) { // метод 2
        view.pupulateOutputLabel(text: text)
    }
    
    func showLoaderView() {
        view.showLoaderView()
    }
    
    func hideLoaderView() {
        view.hideLoaderView()
    }
    
    func showAlertView(text: String) {
        view.showAlertView(text: text)
    }
}
