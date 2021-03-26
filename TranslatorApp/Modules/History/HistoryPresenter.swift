//
//  HistoryPresenter.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/20.
//

import UIKit

protocol HistoryPresenterProtocol: class {
    var router: HistoryRouter! { get set }
    func emptyTableView()
    func configureWords()
    var resultedWords: [Translation] { get set }
    func getFilteredWords(by text: String)
}

class HistoryPresenter: HistoryPresenterProtocol {
    
    var interactor: HistoryInteractorProtocol!
    weak var view: HistoryVCProtocol!
    var router: HistoryRouter!

    var resultedWords = [Translation]()
    
    required init(view: HistoryVCProtocol) {
        self.view = view
    }
    
    func emptyTableView() {
        interactor.deleteAllTheWordsFromDB()
        configureWords()
        view.tableViewReloadData()
    }
    
    func configureWords() {
        resultedWords = []
        guard let fetchedWords = interactor.fetchWordsFromDB() else {
            return
        }
        
        resultedWords = fetchedWords
    }
    
    func getFilteredWords(by text: String) {
        guard let fetchedWords = fetchWords(by: text) else {
            return
        }
        resultedWords = fetchedWords
        view.tableViewReloadData()
    }
    
    private func fetchWords(by key: String) -> [Translation]? {
        return interactor.fetchWords(by: key)
    }
}
