//
//  TranslatorVC.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/20.
//

import UIKit

protocol TranslatorViewProtocol: class {
    func setLeftButton(title: String)
    func setRightButton(title: String)
    
    func populateInputTF(text: String)
    func pupulateOutputLabel(text: String)
    
    func showLoaderView()
    func hideLoaderView()
    func showAlertView(text: String)
}

class TranslatorVC: UIViewController, TranslatorViewProtocol {

    //UI Elements:
    let buttonsField = UIView()
    let leftButton = UIButton()
    let rightButton = UIButton()
    let swapButton = UIButton()
    
    let backView = UIView()
    let inputTF = UITextField()
    let separatorView = UIView()
    let outputLabel = UILabel()
    
    let loaderView = UIActivityIndicatorView(style: .large)
  
    var presenter: TranslatorPresenterProtocol!
    var initializer: TranslatorInit = TranslatorInit()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        initializer.initialize(vc: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializer.initialize(vc: self)
        presenter.configureTranslatorVC()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.updateLanguages()
        //inputTF.text = "Type your text"
        presenter.populateViewWhenAppear()
    }
    
    //MARK:- User Logic Methods
    
    func setLeftButton(title: String) {
        leftButton.setTitle(title, for: .normal)
    }
    
    func setRightButton(title: String) {
        rightButton.setTitle(title, for: .normal)
    }
    
    func populateInputTF(text: String) {
        DispatchQueue.main.async { [weak self] in
            self?.inputTF.text = text
        }
    }
    
    func pupulateOutputLabel(text: String) {
        DispatchQueue.main.async { [weak self] in
            self?.outputLabel.text = text
        }
    }
    
    func showLoaderView() {
        DispatchQueue.main.async { [weak self] in
            self?.loaderView.startAnimating()
        }
    }
    
    func hideLoaderView() {
        DispatchQueue.main.async { [weak self] in
            self?.loaderView.stopAnimating()
        }
    }
    
    func showAlertView(text: String) {
        let alert = UIAlertController(title: "", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Objc Methods
    @objc func swapLanguages() {
        presenter.swapLanguages()
    }
    
    @objc func changeLangLeftButton() {
        presenter.router.presentLanguageListVC(withButtonType: .left)
    }
    
    @objc func changeLangRightButton() {
        presenter.router.presentLanguageListVC(withButtonType: .right)
    }
    
    @objc func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func translate() {
        closeKeyboard()
        
        guard let text = inputTF.text,
              text.count > 0 else {
            return
        }
        presenter.translate(text: text)
    }
    
    //MARK:- UI Methods
    func setupUI() {
        setupSwapButton()
        setupButtonsField()
        setupLeftButton()
        setupRightButton()
        setupTranslationBackView()
        setupInputTF()
        setupSeparatorView()
        setupOutputLabel()
        setupKeyboardToolbar()
        setupLoader()
        view.backgroundColor = .systemYellow
    }
    
    func setupButtonsField() {
        view.addSubview(buttonsField)
        buttonsField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonsField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            buttonsField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            buttonsField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            buttonsField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupSwapButton() {
        buttonsField.addSubview(swapButton)
        swapButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            swapButton.heightAnchor.constraint(equalToConstant: 26),
            swapButton.centerYAnchor.constraint(equalTo: buttonsField.centerYAnchor),
            swapButton.centerXAnchor.constraint(equalTo: buttonsField.centerXAnchor),
            swapButton.widthAnchor.constraint(equalToConstant: 26)
        ])
        swapButton.setImage(Images.swap, for: .normal)
        swapButton.tintColor = .black
        swapButton.addTarget(self, action: #selector(swapLanguages), for: .touchUpInside)
    }
    
    func setupLeftButton() {
        buttonsField.addSubview(leftButton)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftButton.heightAnchor.constraint(equalToConstant: 26),
            leftButton.centerYAnchor.constraint(equalTo: buttonsField.centerYAnchor),
            leftButton.rightAnchor.constraint(equalTo: swapButton.leftAnchor, constant: -20),
            leftButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        leftButton.setTitleColor(.black, for: .normal)
        leftButton.addTarget(self, action: #selector(changeLangLeftButton), for: .touchUpInside)
    }
    
    func setupRightButton() {
        buttonsField.addSubview(rightButton)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rightButton.heightAnchor.constraint(equalToConstant: 26),
            rightButton.centerYAnchor.constraint(equalTo: buttonsField.centerYAnchor),
            rightButton.leftAnchor.constraint(equalTo: swapButton.rightAnchor, constant: 20),
            rightButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        rightButton.setTitleColor(.black, for: .normal)
        rightButton.addTarget(self, action: #selector(changeLangRightButton), for: .touchUpInside)
    }
    
    func setupTranslationBackView() {
        view.addSubview(backView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: buttonsField.bottomAnchor, constant: 10),
            backView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            backView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            backView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        backView.backgroundColor = .white
        backView.layer.cornerRadius = 10
    }
    
    func setupInputTF() {
        backView.addSubview(inputTF)
        inputTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            inputTF.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20),
            inputTF.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 20),
            inputTF.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -20),
            inputTF.heightAnchor.constraint(equalToConstant: 26)
        ])
        inputTF.delegate = self
        inputTF.text = Placeholder.type
    }
    
    func setupSeparatorView() {
        backView.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: inputTF.bottomAnchor, constant: 60),
            separatorView.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 10),
            separatorView.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -10),
            separatorView.heightAnchor.constraint(equalToConstant: 2)
        ])
        separatorView.backgroundColor = .systemGray4
    }
    
    func setupOutputLabel() {
        backView.addSubview(outputLabel)
        outputLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            outputLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 20),
            outputLabel.leftAnchor.constraint(equalTo: inputTF.leftAnchor),
            outputLabel.rightAnchor.constraint(equalTo: inputTF.rightAnchor),
            outputLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupKeyboardToolbar() {
        let keyboardToolBar = UIToolbar(frame: CGRect(x: 0,
                                                      y: 0,
                                                      width: self.view.frame.size.width,
                                                      height: 35))
        let closeButton = UIBarButtonItem(title: ButtonTitles.close,
                                          style: .plain,
                                          target: self,
                                          action: #selector(closeKeyboard))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                     target: nil,
                                     action: nil)
        
        let translateButton = UIBarButtonItem(title: ButtonTitles.translate,
                                              style: .plain,
                                              target: self,
                                              action: #selector(translate))
        
        keyboardToolBar.setItems([closeButton, spacer, translateButton], animated: false)
        keyboardToolBar.sizeToFit()
        inputTF.inputAccessoryView = keyboardToolBar
    }
    
    func setupLoader() {
        loaderView.center = view.center
        view.addSubview(loaderView)
    }
}

extension UIViewController: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.text == Placeholder.type {
            textField.text = ""
            textField.textColor = .black
        }
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            textField.text = Placeholder.type
            textField.textColor = .systemGray3
        }
    }
}
