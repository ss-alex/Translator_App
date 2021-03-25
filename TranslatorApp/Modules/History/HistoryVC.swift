//
//  HistoryVC.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/20.
//

import UIKit

protocol HistoryVCProtocol: class {
    func tableViewReloadData()
}

class HistoryVC: UIViewController, HistoryVCProtocol {
    
    //UI Elements:
    let topView = UIView()
    let navigationLabel = UILabel()
    let deleteButton = UIButton()
    let searchBarView = UIView()
    let searchController = UISearchController(searchResultsController: nil)
    let tableView = UITableView()
    
    //Other properties:
    var presenter: HistoryPresenterProtocol!
    var initializer: HistoryInit = HistoryInit()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializer.inititialize(vc: self)
        setupUI()
        print("History - viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.configureWords()
        tableViewReloadData()
        print("History - viewWillAppear")
    }
    
    func setupUI() {
        setupTopView()
        setupNavigationLabel()
        setupDeleteButton()
        setupSearchBarView()
        setupSearchController()
        setupTableView()
    }
    
    //MARK:- User Logic Methods
    func tableViewReloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func clearTableView() {
        presenter.emptyTableView()
        print("All the words has been deleted.")
    }
    
    //MARK:- UI Methods
    func setupTopView() {
        view.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topView.heightAnchor.constraint(equalToConstant: 80)
        ])
        topView.backgroundColor = .systemYellow
    }
    
    func setupNavigationLabel() {
        topView.addSubview(navigationLabel)
        navigationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -8),
            navigationLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            navigationLabel.widthAnchor.constraint(equalToConstant: 60),
            navigationLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
        navigationLabel.text = "History"
    }
    
    func setupDeleteButton() {
        topView.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -8),
            deleteButton.centerYAnchor.constraint(equalTo: navigationLabel.centerYAnchor),
            deleteButton.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -20),
            deleteButton.widthAnchor.constraint(equalToConstant: 26),
            deleteButton.heightAnchor.constraint(equalToConstant: 26)
        ])
        deleteButton.setImage(UIImage(systemName: "xmark.bin"), for: .normal)
        deleteButton.addTarget(self, action: #selector(clearTableView), for: .touchUpInside)
    }
    
    func setupSearchBarView() {
        view.addSubview(searchBarView)
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            searchBarView.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBarView.rightAnchor.constraint(equalTo: view.rightAnchor),
            searchBarView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupSearchController() {
        searchController.searchBar.placeholder = "Search"
        searchBarView.addSubview(searchController.searchBar)
        searchController.searchBar.sizeToFit()
        searchController.searchBar.frame.size.width = view.frame.size.width
        searchController.searchBar.delegate = self
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "customCell")
    }
    
}

extension HistoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.resultedWords.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! HistoryTableViewCell
        
        let words = presenter.resultedWords
        let input = words[indexPath.row].input
        let translation = words[indexPath.row].translation
        
        cell.setTextToLabels(textOne: input, textTwo: translation)
        return cell
    }
}

extension HistoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.router.dataStore?.translation = presenter.resultedWords[indexPath.row]
        presenter.router.moveToTranslatorVC()
    }
}

extension HistoryVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text,
              text.count > 0 else {
            presenter.configureWords()
            return
        }
        
        presenter.getFilteredWords(by: text)
        searchController.isActive = false
    }
}
