//
//  TranslationIBM.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 25.03.2021.
//

import Foundation

struct TranslationIBM: Codable, Equatable {
    var translation: String

    private enum CodingKeys: String, CodingKey {
        case translation = "translation"
    }
}
