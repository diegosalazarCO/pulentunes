//
//  SearchSceneViewController.swift
//  Pulentunes
//
//  Created by Diego Alexander Salazar on 10/15/19.
//  Copyright (c) 2019 Diego Alexander Salazar. All rights reserved.
//

import UIKit

protocol SearchSceneViewProtocol: class {
    func displayList(withViewModel viewModel: [SearchListViewModel.Item])
}

class SearchSceneViewController: UIViewController, SearchSceneViewProtocol {
    
    var interactor: SearchSceneInteractorProtocol?
    var router: (NSObjectProtocol & SearchSceneRoutingLogic & SearchSceneDataPassing)?
    var songsListViewModel = [SearchListViewModel.Item]()
    private var searchText = ""
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
  
    // MARK: Display
    func startSearch(text: String) {
        interactor?.search(text: text)
    }
  
    func displayList(withViewModel viewModel: [SearchListViewModel.Item]) {
        songsListViewModel = viewModel
        listTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource / UITableViewDelegate

extension SearchSceneViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsListViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchListTableViewCell.identifier, for: indexPath) as? SearchListTableViewCell else {
            return UITableViewCell()
        }
        
        let item = songsListViewModel[indexPath.row]
        cell.setup(forViewModel: item)
        
        return cell
    }
}

extension SearchSceneViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Detail view
    }
}

// MARK: - Searchbar

extension SearchSceneViewController: UISearchBarDelegate, UITextFieldDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchBar.text, searchText.count >= Constants.minSearchTextCount {
            textDidChange(searchBar: searchBar)
        }
    }
    
    func textDidChange(searchBar: UISearchBar) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(didEndEditing), object: searchBar)
        self.perform(#selector(didEndEditing), with: searchBar, afterDelay: Constants.delayForSearching)
    }
    
    @objc func didEndEditing(searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchText = text
        }
        startSearch(text: searchText)
    }
}

// MARK: - Routing

extension SearchSceneViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
}

// MARK: - Private Setup

private extension SearchSceneViewController {
    private func setup() {
        let viewController = self
        let interactor = SearchSceneInteractor()
        let presenter = SearchScenePresenter()
        let router = SearchSceneRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.separatorStyle = .none
    }
    
    struct Constants {
        static let delayForSearching = 0.8
        static let minSearchTextCount = 3
    }
}
