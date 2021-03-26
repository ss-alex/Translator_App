//
//  Constants.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/26.
//

import UIKit

enum Errors {
    static let networkError = "Ошибка соединения"
    static let responseError = "Полученный результат не соответствует параметрам поиска"
}

enum Network {
    static let baseUrl = "https://api.eu-gb.language-translator.watson.cloud.ibm.com/instances/547d2294-cbd7-48c8-8a9b-e8d78b3ccfda"
    static let version = "2018-05-01"
    static let apiKey = "YXBpa2V5OnUwNDlMRnZQMWZXSnk2Q0lUVUU3RW45TUZ4amQydW5vamotM3g0WW9EZUdk"
}

enum CoreData {
    static let enityName = "Translations"
    static let inputKey = "input"
    static let translationKey = "translation"
}

enum TabBarTitles {
    static let translate = "Translate"
    static let history = "History"
}

enum Navigation {
    static let title = "Source language"
    static let history = "History"
}

enum ButtonTitles {
    static let close = "Close"
    static let translate = "Translate"
}

enum Placeholder {
    static let search = "Search"
    static let type = "Type your text"
}

enum Images {
    static let translate = UIImage(systemName: "magnifyingglass")
    static let history = UIImage(systemName: "folder")
    static let swap = UIImage(systemName: "arrow.left.arrow.right")
    static let cancel = UIImage(systemName: "multiply")
    static let delete = UIImage(systemName: "xmark.bin")
}

enum ReuseIdentifiers {
    static let cell = "cell"
    static let customCell = "customCell"
}
