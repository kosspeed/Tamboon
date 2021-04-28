//
//  DonationPresenter.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 23/4/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class DonationPresenter {
    private weak var displayable: DonationDisplayable?
    
    init(displayable: DonationDisplayable) {
        self.displayable = displayable
    }
}

//MARK: Presentable
extension DonationPresenter: DonationPresentable {
    func presentInitialize(response: Donation.Initialize.Response) {
        let viewModel = Donation.Initialize.ViewModel(charityName: response.charity?.name ?? "")
        displayable?.displayInitialize(viewModel: viewModel)
    }
    
    func presentPerformDonate(response: Donation.PerformDonate.Response) {
        var errorMessage: String
        
        switch response.validate {
        case .creditCardNumber:
            errorMessage = "Please fill your credit card number."
        case .creditCardHolder:
            errorMessage = "Please fill your holder person name."
        case .creditCardValidDate:
            errorMessage = "Please fill your valid date."
        case .creditCardCVV:
            errorMessage = "Please fill your CVV."
        case .amount:
            errorMessage = "Please fill your amount."
        default:
            errorMessage = ""
        }
        
        let error = Donation.Error(description: errorMessage)
        let viewModel = Donation.PerformDonate.ViewModel(validate: response.validate,
                                                         error: error)
        
        displayable?.displayPerformDonate(viewModel: viewModel)
    }
    
    func presentDonate(response: Donation.Donate.Response) {
        var wrappedError: Donation.Error?
        
        if let error = response.error {
            let description = error.description + "\n" + error.code.description
            wrappedError = Donation.Error(description: description)
        }
        
        let viewModel = Donation.Donate.ViewModel(status: response.status, error: wrappedError)
        displayable?.displayDonate(viewModel: viewModel)
    }
}
