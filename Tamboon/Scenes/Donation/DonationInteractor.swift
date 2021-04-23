//
//  DonationInteractor.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 23/4/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class DonationInteractor: DonationDataStore {
    var presenter: DonationPresentable
    
    var charity: CharityEntity?
    
    private let config: Config
    private let useCase: DonationUseCase
    
    init(presenter: DonationPresentable, config: Config = .default, useCase: DonationUseCase = DonationUseCaseImpl()) {
        self.presenter = presenter
        self.config = config
        self.useCase = useCase
    }
}

//MARK: BusinessLogic
extension DonationInteractor: DonationBusinessLogic {
    func initialize(request: Donation.Initialize.Request) {
        let response = Donation.Initialize.Response(charity: charity)
        presenter.presentInitialize(response: response)
    }
    
    func performDonate(request: Donation.PerformDonate.Request) {
        var validate: Donation.Validate = .fine
        
        if let creditCardNumber = request.creditCardNumber, creditCardNumber.isEmpty {
            validate = .creditCardNumber
        } else if let creditCardHolder = request.creditCardHolder, creditCardHolder.isEmpty {
            validate = .creditCardHolder
        } else if let creditCardValidDate = request.creditCardValidDate, creditCardValidDate.isEmpty {
            validate = .creditCardValidDate
        } else if let creditCardCVV = request.creditCardCVV, creditCardCVV.isEmpty {
            validate = .creditCardCVV
        } else if let amount = request.amount, amount.isEmpty || amount == "0" {
            validate = .amount
        } else {
            validate = .fine
        }
        
        let response = Donation.PerformDonate.Response(validate: validate)
        presenter.presentPerformDonate(response: response)
    }
    
    func donate(request: Donation.Donate.Request) {
        let amount = Double(request.amount) ?? 0.0
        let token = config.apiToken
        
        useCase.donation(name: request.creditCardHolder, amount: amount, token: token, completion: { [weak self] in
            let response = Donation.Donate.Response(status: .success, error: nil)
            self?.presenter.presentDonate(response: response)
        }, failure: { [weak self] (error) in
            let response = Donation.Donate.Response(status: .failure, error: error)
            self?.presenter.presentDonate(response: response)
        })
    }
}
