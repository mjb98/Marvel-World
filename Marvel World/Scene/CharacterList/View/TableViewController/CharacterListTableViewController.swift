//
//  SuperHeroesListTableViewController.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/9/1400 AP.
//

import Combine
import UIKit

class CharacterListTableViewController: UITableViewController {
    enum Route: String {
        case characterDetail
    }
    
    private let viewModel: CharacterListViewModel
    private let router: Router
    
    
    init(viewModel: CharacterListViewModel, router: Router) {
        self.viewModel = viewModel
        self.router = router
        super.init(style: .plain)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
   
    
    var dataSource: CharacterListDiffableDataSource?
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let loadingCell =  cell as? LoadingCell {
            loadingCell.indictor.startAnimating()
            viewModel.fetchCharacters()
        }
    }
    
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
    
    private func prepareTableView() {
        tableView.delegate = self
        tableView.register(LoadingCell.self, forCellReuseIdentifier: "LoadingCell")
        tableView.register(RetryCell.self, forCellReuseIdentifier: "RetryCell")
        let nib = UINib(nibName: "CharacterTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CharacterTableViewCell")
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
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


class LoadingCell: UITableViewCell {
    let indictor = UIActivityIndicatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        indictor.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(indictor)
        indictor.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indictor.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class RetryCell: BindableTableViewCell {
    let retryButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(retryButton)
        retryButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        retryButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        retryButton.setTitle("Retry", for: .normal)
        retryButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        retryButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        retryButton.setTitleColor(.blue, for: .normal)
        isUserInteractionEnabled = true
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(data: UIAction) {
        retryButton.addAction(data, for: .touchUpInside)
    }
    
    
}


extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}

