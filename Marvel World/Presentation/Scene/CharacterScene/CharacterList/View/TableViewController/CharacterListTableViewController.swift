//
//  SuperHeroesListTableViewController.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/9/1400 AP.
//

import Combine
import UIKit

class CharacterListTableViewController: UITableViewController {
    // MARK: - Routing
    enum Route: String {
        case characterDetail
    }
    // MARK: - Private Properties
    private let viewModel: CharacterListViewModel
    private let router: Router
    private var dataSource: CharacterListDiffableDataSource?
    
    // MARK: - Initilize
    init(viewModel: CharacterListViewModel, router: Router) {
        self.viewModel = viewModel
        self.router = router
        super.init(style: .plain)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        bind()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if dataSource == nil {
            dataSource = .init(tableView: tableView)
            dataSource?.update(with: [], storageController: viewModel.favouritesStorageController)
        }
        tableView.reloadData()
    }
        
    // MARK: - ViewModel Binding
    private func bind() {
        viewModel.$characters.receive(on: RunLoop.main).sink { [weak self] characters in
            guard let self = self else {
                return
            }
            self.dataSource?.update(with: characters, storageController: self.viewModel.favouritesStorageController, isMoreDataAvailable: self.viewModel.isMoreDataAvailable)
        }.store(in: &viewModel.cancelables)
        
        viewModel.$networkError.compactMap { $0 }
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                guard let self = self else {
                    return
                }
                self.dataSource?.setError(characters: self.viewModel.characters, storageController: self.viewModel.favouritesStorageController, error: error, retryAction: .init(handler: { _ in
                    self.dataSource?.update(with: self.viewModel.characters, storageController: self.viewModel.favouritesStorageController, isMoreDataAvailable: self.viewModel.isMoreDataAvailable)
                    
                }))
                
            }.store(in: &viewModel.cancelables)
    }
    // MARK: - Perpare UI
    private func prepareTableView() {
        tableView.delegate = self
        tableView.registerNib(CharacterTableViewCell.self)
        tableView.register(LoadingTableViewCell.self)
        tableView.register(RetryTableViewCell.self)
        tableView.register(NoDataAvailableTableViewCell.self)
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
    }
    
    }
    

// MARK: - Table View Delegate
extension CharacterListTableViewController {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let loadingCell =  cell as? LoadingTableViewCell {
            loadingCell.startAnimation()
            viewModel.fetchCharacters()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 0 ? 150 : 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let character = viewModel.characters[indexPath.row]
            router.route(to: Route.characterDetail.rawValue, from: self, parameters: [DataSourceKey.character : character])
        }
}
}
