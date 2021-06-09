//
//  CharacterListRouter.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/19/1400 AP.
//

import UIKit

class CharacterListRouter: Router {
    unowned let viewModel: CharacterListViewModel
    
    init(viewModel: CharacterListViewModel) {
        self.viewModel = viewModel
    }
    
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
        let destinationViewModel = CharacterDetailViewModel(character: character)
        let destinationViewController = CharacterDetailViewController(viewModel: destinationViewModel)
        destinationViewController.title = character.name
        context.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
}
