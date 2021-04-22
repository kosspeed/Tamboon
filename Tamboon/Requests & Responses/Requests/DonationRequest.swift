//
//  DonationRequest.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 22/4/2564 BE.
//

import Foundation

class DonationRequest: BaseRequest {
    let name: String
    let token: String
    let amount: Double
    
    init(name: String, token: String, amount: Double) {
        self.name = name
        self.token = token
        self.amount = amount
    }
}
