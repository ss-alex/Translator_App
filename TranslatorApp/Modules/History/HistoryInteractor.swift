//
//  HistoryInteractor.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/20.
//

import UIKit

protocol HistoryDS {
    var translation: Translation? { get set }
}

protocol HistoryInteractorProtocol: class {
    func fetchWordsFromDB() -> [Translation]?
    func deleteAllTheWordsFromDB()
    func fetchWords(by key: String) -> [Translation]?
}

class HistoryInteractor: HistoryInteractorProtocol, HistoryDS {
    var translation: Translation?
    let storageSerice: StorageServiceProtocol = StorageService()
    weak var presenter: HistoryPresenterProtocol!
    
    required init(presenter: HistoryPresenterProtocol) {
        self.presenter = presenter
    }
    
    func fetchWordsFromDB() -> [Translation]? {
        return storageSerice.getWordsFromDB()
    }
    
    func deleteAllTheWordsFromDB() {
        storageSerice.deleteAllTheWordsFromDB()
    }
    
    func fetchWords(by key: String) -> [Translation]? {
        return storageSerice.fetchWords(by: key)
    }
}
