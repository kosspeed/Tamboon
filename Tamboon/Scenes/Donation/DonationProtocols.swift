//
//  DonationProtocols.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 23/4/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

//MARK: ViewController
protocol DonationDisplayable: class {
    func displayInitialize(viewModel: Donation.Initialize.ViewModel)
    func displayPerformDonate(viewModel: Donation.PerformDonate.ViewModel)
    func displayDonate(viewModel: Donation.Donate.ViewModel)
}

//MARK: Interactor
protocol DonationBusinessLogic {
    func initialize(request: Donation.Initialize.Request)
    func performDonate(request: Donation.PerformDonate.Request)
    func donate(request: Donation.Donate.Request)
}

//MARK: Presenter
protocol DonationPresentable {
    func presentInitialize(response: Donation.Initialize.Response)
    func presentPerformDonate(response: Donation.PerformDonate.Response)
    func presentDonate(response: Donation.Donate.Response)
}

//MARK: Routable
protocol DonationRoutable {
    
}

//MARK: DataStore
protocol DonationDataStore {
    var charity: CharityEntity? { get set }
}

//MARK: DataPassing
protocol DonationDataPassing {
    var dataStore: DonationDataStore? { get set }
}
