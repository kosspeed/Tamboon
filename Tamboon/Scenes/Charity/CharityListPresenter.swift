//
//  CharityListPresenter.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 23/4/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class CharityListPresenter {
    private weak var displayable: CharityListDisplayable?
    
    init(displayable: CharityListDisplayable) {
        self.displayable = displayable
    }
}

//MARK: Presentable
extension CharityListPresenter: CharityListPresentable {
    func presentGetCharities(response: CharityList.GetCharities.Response) {
        let placeholderImage = UIImage(named: "ic_not_found")
        
        let charities: [CharityList.Charity]? = response.charities?.map {
            .init(id: $0.id,
                  name: $0.name,
                  logoUrl: URL(string: $0.logoUrl),
                  placeholderImage: placeholderImage)
        }
        
        var wrappedError: CharityList.Error?
        
        if let error = response.error {
            let description = error.localizedDescription + "\n" + error.code.description
            wrappedError = CharityList.Error(description: description)
        }
        
        let viewModel = CharityList.GetCharities.ViewModel(status: response.status,
                                                           charities: charities,
                                                           error: wrappedError)
        displayable?.displayGetCharities(viewModel: viewModel)
    }
    
    func presentPerformDonation(response: CharityList.PerformDonation.Response) {
        let viewModel = CharityList.PerformDonation.ViewModel(charity: response.charity)
        displayable?.displayPerformDonation(viewModel: viewModel)
    }
}
