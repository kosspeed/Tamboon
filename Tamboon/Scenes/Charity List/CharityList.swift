//
//  CharityList.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 23/4/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct CharityList {
    
    //MARK: Use Cases
    struct GetCharities {
        struct Request {
            
        }
        
        struct Response {
            let status: ServiceStatus
            let charities: [CharityEntity]?
            let error: ErrorEntity?
        }
        
        struct ViewModel {
            let status: ServiceStatus
            let charities: [Charity]?
            let error: Error?
        }
    }
    
    struct PerformDonation {
        struct Request {
            let charityId: Int
        }
        
        struct Response {
            let charity: CharityEntity?
        }
        
        struct ViewModel {
            let charity: CharityEntity?
        }
    }
    
    struct Charity {
        let id: Int
        let name: String
        let logoUrl: URL?
        let placeholderImage: UIImage?
    }
    
    struct Error {
        let description: String
    }
    
    enum ServiceStatus {
        case success
        case failure
    }
}
