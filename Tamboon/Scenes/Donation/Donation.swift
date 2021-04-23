//
//  Donation.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 23/4/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct Donation {
    
    //MARK: Use Cases
    struct Initialize {
        struct Request {
            
        }
        
        struct Response {
            let charity: CharityEntity?
        }
        
        struct ViewModel {
            let charityName: String
        }
    }
    
    struct PerformDonate {
        struct Request {
            let creditCardNumber: String?
            let creditCardHolder: String?
            let creditCardValidDate: String?
            let creditCardCVV: String?
            let amount: String?
        }
        
        struct Response {
            let validate: Validate
        }
        
        struct ViewModel {
            let validate: Validate
            let error: Error?
        }
    }
    
    struct Donate {
        struct Request {
            let creditCardNumber: String
            let creditCardHolder: String
            let creditCardValidDate: String
            let creditCardCVV: String
            let amount: String
        }
        
        struct Response {
            let status: ServiceStatus
            let error: ErrorEntity?
        }
        
        struct ViewModel {
            let status: ServiceStatus
            let error: Error?
        }
    }
    
    enum Validate {
        case creditCardNumber
        case creditCardHolder
        case creditCardValidDate
        case creditCardCVV
        case amount
        case fine
    }
    
    struct Error {
        let description: String
    }
    
    enum ServiceStatus {
        case success
        case failure
    }
}
