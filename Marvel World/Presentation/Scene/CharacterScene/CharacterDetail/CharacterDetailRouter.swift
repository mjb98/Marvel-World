//
//  CharacterDetailRouter.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/19/1400 AP.
//

import UIKit

class CharacterDetailRouter: Router {
    // MARK: - Private Properties
    unowned private let viewModel: CharacterDetailViewModel
    
    // MARK: - Intilize
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Routing
    func route(to routeID: String, from context: UIViewController, parameters: [DataSourceKey : Any]?) {
        switch routeID {
        case CharacterDetailViewController.Route.appearancelist.rawValue:
            guard let list = parameters?[.appearanceList] as? [Appearance], let type = parameters?[.appearanceType] as? AppearanceType else { return }
            routeToAppearnceList(appearance: list, type: type, context: context)
        default: break
        }
    }
    
    private func routeToAppearnceList(appearance: [Appearance], type: AppearanceType, context: UIViewController) {
        let destinationViewModel = AppearanceListViewModel(appearances: appearance)
        let destinationViewController = AppearanceListTableViewController(viewModel: destinationViewModel)
        destinationViewController.title = type.rawValue.capitalizingFirstLetter()
        context.navigationController?.pushViewController(destinationViewController, animated: true)
    }
}
