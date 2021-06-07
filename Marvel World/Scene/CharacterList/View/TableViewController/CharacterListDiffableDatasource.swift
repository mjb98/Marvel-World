//
//  CharacterListDiffableDatasource.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/16/1400 AP.
//

import Foundation
import UIKit


class CharacterListDiffableDataSource {
    private var dataSource: UITableViewDiffableDataSource<Section, CellWrapper>?
    
    
    init(tableView: UITableView) {
        self.dataSource = makeDataSource(tableView: tableView)
    }
    
    func update(with list: [Character],storageController: FavouritesStroageController, isMoreDataAvailable: Bool = true) {
        var snapshot =  createSnapShot(with: list, stroageController: storageController)
        if isMoreDataAvailable {
            snapshot.appendItems([CellWrapper.loadingCell], toSection: .loading)
        }
        dataSource?.apply(snapshot, animatingDifferences: false)
        
    }
    
    func setError(characters: [Character],storageController: FavouritesStroageController, error: Error, retryAction: UIAction) {
        var snapshot =  createSnapShot(with: characters, stroageController: storageController)
        snapshot.appendItems([CellWrapper.retryCell(action: retryAction)], toSection: .Retry)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    private func createSnapShot(with list: [Character], stroageController: FavouritesStroageController) -> NSDiffableDataSourceSnapshot<Section, CellWrapper> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CellWrapper>()
        snapshot.appendSections(Section.allCases)
        let characters = list.uniqued().map { character in
            CellWrapper.characterCell(viewModel: .init(character: character, favouriteStroageController: stroageController))
        }
        snapshot.appendItems(characters, toSection: .character)
        return snapshot
    }
    
    
}


extension CharacterListDiffableDataSource {
    fileprivate func makeDataSource(tableView: UITableView) -> UITableViewDiffableDataSource<Section, CellWrapper> {
        
        let dataSource =  UITableViewDiffableDataSource<Section, CellWrapper>(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, wrapper in
                
                switch wrapper {
                case .characterCell(let character):
                    let cell = wrapper.dequeCell(in: tableView, indexPath: indexPath, for: CharacterTableViewCell.self)
                    cell.bind(data: character)
                    return cell
                case .loadingCell:
                    let cell = wrapper.dequeCell(in: tableView, indexPath: indexPath, for: LoadingCell.self)
                    return cell
                case .retryCell(let action):
                    let cell = wrapper.dequeCell(in: tableView, indexPath: indexPath, for: RetryCell.self)
                    cell.bind(data: action)
                    return cell
                }
                
            }
        )
        return dataSource
    }
}

extension CharacterListDiffableDataSource {
    enum Section: CaseIterable {
        case character
        case loading
        case Retry
    }
    
    enum CellWrapper: Hashable {
        case characterCell(viewModel: CharacterCellViewModel)
        case loadingCell
        case retryCell(action: UIAction)
        
        var reuseIdentifer: String {
            switch self {
            case .characterCell:
                return "CharacterTableViewCell"
            case .loadingCell:
                return "LoadingCell"
            case .retryCell:
                return "RetryCell"
            }
        }
        
        func dequeCell<T: UITableViewCell>(in tableView: UITableView,indexPath: IndexPath, for type: T.Type) -> T {
            return tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifer, for: indexPath) as! T
        }
        
        
    }
    
    
}



