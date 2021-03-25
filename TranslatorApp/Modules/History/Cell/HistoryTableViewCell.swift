//
//  TableViewCell.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/24.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    let inputLabel = UILabel()
    let translationLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInputLabel()
        setupTranslationLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTextToLabels(textOne: String, textTwo: String){
        self.inputLabel.text = textOne
        self.translationLabel.text = textTwo
    }
    
    func setupInputLabel() {
        addSubview(inputLabel)
        inputLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            inputLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40),
            inputLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            inputLabel.widthAnchor.constraint(equalToConstant: 80),
            inputLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupTranslationLabel() {
        addSubview(translationLabel)
        translationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            translationLabel.leftAnchor.constraint(equalTo: inputLabel.rightAnchor, constant: 80),
            translationLabel.centerYAnchor.constraint(equalTo: inputLabel.centerYAnchor),
            translationLabel.widthAnchor.constraint(equalToConstant: 100),
            translationLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}

