//
//  CharityListRouter.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 23/4/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class CharityListRouter:  CharityListDataPassing {
    private weak var viewController: CharityListViewController?
    var dataStore: CharityListDataStore?
    
    init(viewController: CharityListViewController) {
        self.viewController = viewController
    }
}

//MARK: Routable
extension CharityListRouter: CharityListRoutable {
    func routeToDonation(charity: CharityEntity) {
        let storyboard = DonationViewController.storyboard
        let destination = storyboard.instantiateViewController(identifier: DonationViewController.string) as! DonationViewController
        destination.router.dataStore?.charity = charity
        
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
