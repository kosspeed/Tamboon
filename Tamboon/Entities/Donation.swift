//
//  Donation.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 22/4/2564 BE.
//

import Foundation

struct Donation {
    var name: String
    var token: String
    var amount: Double
}

//MARK: Transform
extension Donation {
    var request: DonationRequest {
        return DonationRequest(name: name,
                               token: token,
                               amount: amount)
    }
}
