//
//  Word.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/20.
//

import Foundation

struct TranslationResult: Codable, Equatable {
    var wordCount: Int
    var characterCount: Int
    var detectedLanguage: String?
    var detectedLanguageConfidence: Double?
    var translations: [TranslationIBM]

    private enum CodingKeys: String, CodingKey {
        case wordCount = "word_count"
        case characterCount = "character_count"
        case detectedLanguage = "detected_language"
        case detectedLanguageConfidence = "detected_language_confidence"
        case translations = "translations"
    }
}
