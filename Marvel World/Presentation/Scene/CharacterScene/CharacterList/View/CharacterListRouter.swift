//
//  CharacterListRouter.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/19/1400 AP.
//

import UIKit

class CharacterListRouter: Router {
    // MARK: - Private Properties
    unowned private let viewModel: CharacterListViewModel
    
    // MARK: - Initilizer
    init(viewModel: CharacterListViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Routing
    func route(to routeID: String, from context: UIViewController, parameters: [DataSourceKey: Any]?) {
        switch routeID {
        case CharacterListTableViewController.Route.characterDetail.rawValue:
            guard let character = parameters?[.character] as? Character else {
                return
            }
            routeToCharacterDetail(character: character, context: context)
        default:
            break
        }
        
    }
    
    private func routeToCharacterDetail(character: Character, context: UIViewController) {
        let destinationViewModel = CharacterDetailViewModel(character: character, favouritesStorageController: viewModel.favouritesStorageController)
        let destinationRouter = CharacterDetailRouter(viewModel: destinationViewModel)
        let destinationViewController = CharacterDetailViewController(viewModel: destinationViewModel, router: destinationRouter)
        destinationViewController.title = character.name
        context.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
}
