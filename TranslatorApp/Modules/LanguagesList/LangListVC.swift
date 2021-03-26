//
//  LanguagesListVC.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/20.
//

import UIKit

protocol LangListViewProtocol: class {
    func reloadData()
}

class LangListVC: UIViewController, LangListViewProtocol {
    
    let tableView = UITableView()
    
    var presenter: LangListPresenterProtocol!
    var initializer: LangListInit = LangListInit()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializer.initialize(viewController: self)
        presenter.configureView()
        setupUI()
    }
    
    //MARK:- User Logic Methods
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    //MARK:- UI Methods
    func setupUI() {
        setupTableView()
        setupNavigationBar()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 54),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        tableView.backgroundColor = .white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReuseIdentifiers.cell)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupNavigationBar() {
        let width = self.view.frame.width
        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        self.view.addSubview(navigationBar)
        let navigationItem = UINavigationItem(title: Navigation.title)
        let cancelButton = UIBarButtonItem(image: Images.cancel?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(dismissView))
        cancelButton.tintColor = .black
        navigationItem.leftBarButtonItem = cancelButton
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.backgroundColor = .systemYellow
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}

extension LangListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectedLanguage = presenter.languageNames[indexPath.row]
        presenter.router?.routeToTranslatorVC()
    }
    
}

extension LangListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.cell)!
        cell.textLabel?.text = presenter.languageNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.languageNames.count
    }
}


