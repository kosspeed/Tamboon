//
//  CharityListViewController.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 23/4/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class CharityListViewController: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet private weak var emptyView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: VIP Cycle
    var interactor: CharityListBusinessLogic!
    var router: (CharityListRoutable & CharityListDataPassing)!
    
    //MARK: Properties
    private var charities: [CharityList.Charity]?
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getCharities()
    }
}

//MARK: Setup & Configuration
private extension CharityListViewController {
    func configure() {
        let viewController = self
        let router = CharityListRouter(viewController: viewController)
        let presenter = CharityListPresenter(displayable: viewController)
        let interactor = CharityListInteractor(presenter: presenter)
        
        viewController.interactor = interactor
        viewController.router = router
        viewController.router.dataStore = interactor
    }
    
    func setup() {
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(cell: CharityTableViewCell.self)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK: Logics
private extension CharityListViewController {
    func getCharities() {
        let request = CharityList.GetCharities.Request()
        interactor.getCharities(request: request)
    }
    
    func performDonation(charityId: Int) {
        let request = CharityList.PerformDonation.Request(charityId: charityId)
        interactor.performDonation(request: request)
    }
    
    func routeToDonation(charity: CharityEntity) {
        router.routeToDonation(charity: charity)
    }
}

//MARK: UITableViewDataSource & UITableViewDelegate
extension CharityListViewController: UITableViewDataSource & UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(by: CharityTableViewCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        
        guard let charity = charities?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.didTapped.delegate(to: self) { (self, _) in
            self.performDonation(charityId: charity.id)
        }
        
        cell.configure(charity: charity)
        
        return cell
    }
}

//MARK: Displayable
extension CharityListViewController: CharityListDisplayable {
    func displayGetCharities(viewModel: CharityList.GetCharities.ViewModel) {
        switch viewModel.status {
        case.success:
            charities = viewModel.charities
            
            emptyView.isHidden = true
            tableView.reloadData()
        case .failure:
            emptyView.isHidden = false
            alert(message: viewModel.error?.description ?? "")
        }
    }
    
    func displayPerformDonation(viewModel: CharityList.PerformDonation.ViewModel) {
        guard let charity = viewModel.charity else { return }
        routeToDonation(charity: charity)
    }
}

