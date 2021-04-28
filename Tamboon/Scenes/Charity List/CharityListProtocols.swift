//
//  CharityListProtocols.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 23/4/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

//MARK: ViewController
protocol CharityListDisplayable: class {
    func displayGetCharities(viewModel: CharityList.GetCharities.ViewModel)
    func displayPerformDonation(viewModel: CharityList.PerformDonation.ViewModel)
}

//MARK: Interactor
protocol CharityListBusinessLogic {
    func getCharities(request: CharityList.GetCharities.Request)
    func performDonation(request: CharityList.PerformDonation.Request)
}

//MARK: Presenter
protocol CharityListPresentable {
    func presentGetCharities(response: CharityList.GetCharities.Response)
    func presentPerformDonation(response: CharityList.PerformDonation.Response)
}

//MARK: Routable
protocol CharityListRoutable {
    func routeToDonation(charity: CharityEntity)
}

//MARK: DataStore
protocol CharityListDataStore {
    var charities: [CharityEntity]? { get set }
}

//MARK: DataPassing
protocol CharityListDataPassing {
    var dataStore: CharityListDataStore? { get set }
}
