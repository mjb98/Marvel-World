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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add(child: tableViewController, container: superheroesListContainer)
    }
    
    


}
