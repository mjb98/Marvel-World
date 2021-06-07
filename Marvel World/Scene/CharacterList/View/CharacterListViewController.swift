//
//  SuperHerosListViewController.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/9/1400 AP.
//

import Combine
import UIKit

class CharacterListViewController: UIViewController {
    @IBOutlet private weak var searchBarContainer: UIView!
    @IBOutlet private weak var superheroesListContainer: UIView!
    private var can =  Set<AnyCancellable>()
    
    private lazy var tableViewController: CharacterListTableViewController = .init(viewModel: .init())
    private var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add(child: tableViewController, container: superheroesListContainer)
        setupSearchController()
    }
    
    


}

extension CharacterListViewController {
    private func setupSearchController() {
      
//        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "iewModel.searchBarPlaceholder"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = true
      
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.frame = searchBarContainer.bounds
        searchController.searchBar.autoresizingMask = [.flexibleWidth]
        searchBarContainer.addSubview(searchController.searchBar)
        definesPresentationContext = true
       
    }
}
