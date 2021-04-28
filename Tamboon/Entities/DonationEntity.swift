//
//  DonationEntity.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 22/4/2564 BE.
//

import Foundation

struct DonationEntity {
    var name: String
    var token: String
    var amount: Double
}

//MARK: Transform
extension DonationEntity {
    var request: DonationRequest {
        return DonationRequest(name: name,
                               token: token,
                               amount: amount)
    }
}
