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
    
}


extension CharacterListDiffableDataSource {
    fileprivate func makeDataSource(tableView: UITableView) -> UITableViewDiffableDataSource<Section, CellWrapper> {
 
        let dataSource =  UITableViewDiffableDataSource<Section, CellWrapper>(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, wrapper in
                
                switch wrapper {
                case .characterCell(let character):
                    let cell = wrapper.dequeCell(in: tableView, indexPath: indexPath, for: CharacterCell.self)
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
        case characterCell(character: Character)
        case loadingCell
        case retryCell(action: UIAction)
        
        var reuseIdentifer: String {
            switch self {
            case .characterCell:
                return "CharacterCell"
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

protocol Bindable {
    associatedtype T
    func bind(data: T)
}
extension Bindable {
    func bind(data: T) {
        
    }
}

typealias BindableTableViewCell = Bindable & UITableViewCell

