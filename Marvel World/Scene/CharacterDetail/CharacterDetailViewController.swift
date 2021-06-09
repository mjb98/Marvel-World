//
//  CharacterDetailViewController.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/17/1400 AP.
//

import Combine
import UIKit

class CharacterDetailViewController: UITableViewController {
    
    enum Route: String {
        case appearancelist
    }
    
    private var can = Set<AnyCancellable>()
    let viewModel: CharacterDetailViewModel
    let router: Router
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CharacterHeaderTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HeaderTableViewCell")
        tableView.register(AppearanceCell.self, forCellReuseIdentifier: "1")
        tableView.separatorStyle = .none
        bind()
        
    }
    
    
    init(viewModel: CharacterDetailViewModel, router: Router) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    private func bind() {
        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .dropFirst()
            .sink { isLoading in
                isLoading ? LoadingView.show(on: self) : LoadingView.hide()
            }.store(in: &viewModel.cancelables)
        
        viewModel.appearancesFetched.receive(on: RunLoop.main)
            .sinkToResult { [weak self] res in
                guard let self = self else {
                    return
                }
                switch res {
                case .success(let data) :
                    self.router.route(to: Route.appearancelist.rawValue, from: self, parameters: [DataSourceKey.appearanceList : data.list, .appearanceType: data.type])
                break
                case .failure(let error):
                    break
                }
            }.store(in: &viewModel.cancelables)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == Section.header.sectionIndex {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! CharacterHeaderTableViewCell
            cell.configure(with: viewModel.character)
            return cell
        }
        else {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "1", for: indexPath) as! AppearanceCell
            cell.bind(data: .init(type: viewModel.availableAppearnces[indexPath.row], buttonAction: {
                self.viewModel.fetchAppearances(type:self.viewModel.availableAppearnces[indexPath.row]  )
            }))
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : viewModel.availableAppearnces.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 0 ? UITableView.automaticDimension : 50
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 0 ? 800 : 50
    }
    enum Section: Int, CaseIterable {
        case header
        case appearanceList
        
        var sectionIndex: Int {
            rawValue
        }
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
        showAppearanceButton.titleLabel?.font = UIFont(name: "avenir", size: 16)
        
        
    }
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(data: AppearanceCellViewModel) {
        viewModel = data
        showAppearanceButton.setTitle(viewModel?.title, for: .normal)
        showAppearanceButton.addAction(.init(handler: { _ in
            data.buttonAction()
        }), for: .touchUpInside)
        
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

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
