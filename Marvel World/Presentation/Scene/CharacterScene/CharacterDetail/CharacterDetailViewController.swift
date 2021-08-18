//
//  CharacterDetailViewController.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/17/1400 AP.
//

import Combine
import UIKit

class CharacterDetailViewController: UITableViewController, Alertable {
    // MARK: - Routing
    enum Route: String {
        case appearancelist
    }
    // MARK: - Private  Properties
    private let viewModel: CharacterDetailViewModel
    private let router: Router
    
    // MARK: - Initilize
    init(viewModel: CharacterDetailViewModel, router: Router) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
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
    // MARK: - Prepare UI
    private func prepareTableView() {
        tableView.registerNib(CharacterHeaderTableViewCell.self)
        tableView.register(ShowAppearanceTableViewCell.self)
        tableView.separatorStyle = .none

    }
    
    
    // MARK: - ViewModel Binding
    private func bind() {
        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .dropFirst()
            .sink { isLoading in
                isLoading ? LoadingView.show(on: self) : LoadingView.hide()
            }.store(in: &viewModel.cancelables)
        
        viewModel.appearancesFetched.receive(on: RunLoop.main)
            .sinkToResult { [weak self] res in
                guard let self = self else {
                    return
                }
                switch res {
                case .success(let data) :
                    self.router.route(to: Route.appearancelist.rawValue, from: self, parameters: [DataSourceKey.appearanceList : data.list, .appearanceType: data.type])
                    break
                case .failure(let error):
                    self.showAlert(message: error.localizedDescription)
                }
            }.store(in: &viewModel.cancelables)
        
    }
    
    
}

// MARK: - Table view data source and Delegate
extension CharacterDetailViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : viewModel.availableAppearnces.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 0 ? UITableView.automaticDimension : 50
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 0 ? 800 : 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == Section.header.sectionIndex {
            let cell =  tableView.dequeueReusableCell(cell: CharacterHeaderTableViewCell.self, at: indexPath)
            cell.bind(data: .init(character: viewModel.character, favouriteStroageController: viewModel.favouritesStorageController))
            return cell
        }
        else {
            let cell =  tableView.dequeueReusableCell(cell: ShowAppearanceTableViewCell.self, at: indexPath)
            let type = viewModel.availableAppearnces[indexPath.row]
            cell.bind(data: .init(type: type , buttonAction: { [weak self] in
                self?.viewModel.fetchAppearances(type: type)
            }))
            return cell
        }
        
    }
    enum Section: Int, CaseIterable {
        case header
        case appearanceList
        
        var sectionIndex: Int {
            rawValue
        }
    }
}
