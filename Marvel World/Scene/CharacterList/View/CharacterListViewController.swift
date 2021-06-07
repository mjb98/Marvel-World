//
//  SuperHerosListViewController.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/9/1400 AP.
//

import Combine
import UIKit

class CharacterListViewController: UIViewController {
    @IBOutlet private weak var superheroesListContainer: UIView!
    
    private var viewModel: CharacterListViewModel
    private var tableViewController: CharacterListTableViewController!
    private var searchController = UISearchController(searchResultsController: nil)
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewController = .init(viewModel: viewModel)
        add(child: tableViewController, container: superheroesListContainer)
        setupSearchBarListeners()
        setupSearchController()
        bind()
    }
    
    init(viewModel: CharacterListViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSearchBarListeners() {
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchController.searchBar.searchTextField)
        publisher
            .map {
            ($0.object as! UISearchTextField).text
        }
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { (str) in
                guard let query = str else  { return }
                self.viewModel.didSearch(query: query)
            }.store(in: &viewModel.cancelables)
    }
    
    private func bind() {
        viewModel.$isSearchBarHidden
            .receive(on: RunLoop.main)
            .dropFirst()
            .assign(to: \.isHidden, on: searchController.searchBar)
            .store(in: &viewModel.cancelables)
        
        viewModel.$navigationTitle
            .receive(on: RunLoop.main)
            .dropFirst()
            .compactMap {$0}
            .assign(to: \.title, on: navigationItem)
            .store(in: &viewModel.cancelables)
            
    }
    
    
}

extension CharacterListViewController {
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search..."
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.autoresizingMask = [.flexibleWidth]
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = viewModel.navigationTitle
        navigationItem.rightBarButtonItem = .init(image: UIImage(named: "like"), style: .done, target: self, action: #selector(showFavouriteCharacterList))
        
        
    }
    @objc
    func showFavouriteCharacterList() {
        navigationItem.rightBarButtonItem = .init(image: UIImage(named: "likeFilled")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(hideFavouriteCharacterList))
        viewModel.showFavouriteCharacters()
    }
    @objc
    func hideFavouriteCharacterList() {
        navigationItem.rightBarButtonItem = .init(image: UIImage(named: "like"), style: .done, target: self, action: #selector(showFavouriteCharacterList))
        viewModel.hideFavouriteCharacters()
    }
}

extension CharacterListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        searchController.isActive = false
  
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.didCancelSearch()
    }
}
