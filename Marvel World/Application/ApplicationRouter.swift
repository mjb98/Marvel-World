//
//  ApplicationRouter.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/19/1400 AP.
//

import UIKit

class ApplicationRouter: Router {
    enum Route: String {
        case characterList
    }
    func route(to routeID: String, from context: UIViewController, parameters: [DataSourceKey : Any]?) {
        if routeID == Route.characterList.rawValue {
        let characterLoader = NetworkCharacterLoader()
        let storageController = FavouritesStroageController()
        let destinationViewModel = CharacterListViewModel(characterLoader: characterLoader, favouritesStorageController: storageController)
        let destinationViewController = CharacterListViewController(viewModel: destinationViewModel)
        if let navigationController = context as? UINavigationController {
            navigationController.pushViewController(destinationViewController, animated: true)
        }
        }
    }
}
