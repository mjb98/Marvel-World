//
//  AppearanceListTableViewController.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/19/1400 AP.
//

import UIKit

class AppearanceListTableViewController: UITableViewController {
    // MARK: - Private  Properties
   private let viewModel: AppearanceListViewModel
    
    // MARK: - Initlizer
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: AppearanceListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(AppearanceTableViewCell.self)
        tableView.separatorStyle = .singleLine
    }
    
}


// MARK: - Table view data source and Delegate
extension AppearanceListTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.appearances.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cell: AppearanceTableViewCell.self, at: indexPath)
        cell.bind(data: viewModel.appearances[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}
