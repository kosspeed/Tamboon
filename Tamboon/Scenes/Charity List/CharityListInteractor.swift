//
//  CharityListInteractor.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 23/4/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class CharityListInteractor: CharityListDataStore {
    var presenter: CharityListPresentable
    
    var charities: [CharityEntity]?
        
    private let useCase: GetCharitiesUseCase
    
    init(presenter: CharityListPresentable, useCase: GetCharitiesUseCase = GetCharitiesUseCaseImpl()) {
        self.presenter = presenter
        self.useCase = useCase
    }
}

//MARK: BusinessLogic
extension CharityListInteractor: CharityListBusinessLogic {
    func getCharities(request: CharityList.GetCharities.Request) {
        useCase.execute(completion: { [weak self] (charities) in
            self?.charities = charities
            
            let response = CharityList.GetCharities.Response(status: .success,
                                                             charities: charities,
                                                             error: nil)
            self?.presenter.presentGetCharities(response: response)
        }, failure: { [weak self] (error) in
            let response = CharityList.GetCharities.Response(status: .failure,
                                                             charities: nil,
                                                             error: error)
            self?.presenter.presentGetCharities(response: response)
        })
    }
    
    func performDonation(request: CharityList.PerformDonation.Request) {
        let charity = charities?.filter { $0.id == request.charityId }.first
        let response = CharityList.PerformDonation.Response(charity: charity)
        
        presenter.presentPerformDonation(response: response)
    }
}
