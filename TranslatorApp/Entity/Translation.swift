//
//  Word.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/20.
//

import UIKit

class Translation: NSObject {
    var input: String
    var translation: String

    required init(input: String, translation: String) {
        self.input = input
        self.translation = translation
    }
}

