//
//  DonationRouter.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 23/4/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class DonationRouter:  DonationDataPassing {
    private weak var viewController: DonationViewController?
    var dataStore: DonationDataStore?
    
    init(viewController: DonationViewController) {
        self.viewController = viewController
    }
}

//MARK: Routable
extension DonationRouter: DonationRoutable {
    
}
