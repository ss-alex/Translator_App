//
//  LanguageService.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/20.
//

import Foundation

import UIKit

protocol LanguageServiceProtocol {
    var leftLanguage: Language { set get }
    var rightLanguage: Language { set get }
}

class LanguageService: LanguageServiceProtocol {
    
    var leftLanguage: Language
    var rightLanguage: Language
    
    init() {
        leftLanguage = Language.defaultLeftLanguage()
        rightLanguage = Language.defaultRightLanguage()
    }
}

