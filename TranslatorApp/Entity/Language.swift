//
//  Language.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/20.
//

import UIKit

class Language: NSObject {
    var name: String!
    var code: String!
    
    required init(name: String, code: String) {
        self.name = name
        self.code = code
    }
    
    static func defaultLeftLanguage() -> Language {
        return self.init(name: "English", code: "en")
    }
    
    static func defaultRightLanguage() -> Language {
        return self.init(name: "Russian", code: "ru")
    }
}
