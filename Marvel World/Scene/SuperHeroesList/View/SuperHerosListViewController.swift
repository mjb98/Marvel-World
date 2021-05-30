//
//  SuperHerosListViewController.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/9/1400 AP.
//

import UIKit

class SuperHerosListViewController: UIViewController {
    @IBOutlet private weak var searchBarContainer: UIView!
    @IBOutlet private weak var superheroesListContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add(child: SuperHeroesListTableViewController(), container: superheroesListContainer)

        // Do any additional setup after loading the view.
    }


}
