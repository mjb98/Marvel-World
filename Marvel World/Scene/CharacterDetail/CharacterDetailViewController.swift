//
//  CharacterDetailViewController.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/17/1400 AP.
//

import UIKit

class CharacterDetailViewController: UITableViewController {
    let character: Character
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "HeaderTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HeaderTableViewCell")
        tableView.register(AppearanceCell.self, forCellReuseIdentifier: "1")
        tableView.separatorStyle = .none
        
       
     
    }
    
    let types = AppearanceType.allCases
    
    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
            cell.configure(with: character)
            return cell
        }
       else {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "1", for: indexPath) as! AppearanceCell
            cell.bind(data: .init(type: types[indexPath.row], buttonAction: {
                
            }))
            return cell
        }
    
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 0 ? 1 : types.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 0 ? UITableView.automaticDimension : 50
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 0 ? 800 : 50
    }

   
}


class AppearanceCell: BindableTableViewCell {
    var showAppearanceButton = UIButton(type: .system)
    private var viewModel: AppearanceCellViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
        selectionStyle = .none

    }
    
    private func setUp() {
        showAppearanceButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(showAppearanceButton)
        showAppearanceButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        showAppearanceButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        showAppearanceButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        showAppearanceButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
       
       
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(data: AppearanceCellViewModel) {
        viewModel = data
        showAppearanceButton.setTitle(viewModel?.title, for: .normal)
        
    }
    
    
}

class AppearanceCellViewModel {
    let buttonAction: () -> ()
    let type: AppearanceType
    
    var title: String {
        "show \(type)"
    }
    
    init(type: AppearanceType, buttonAction: @escaping () -> ()) {
        self.buttonAction = buttonAction
        self.type = type
    }
    
}
