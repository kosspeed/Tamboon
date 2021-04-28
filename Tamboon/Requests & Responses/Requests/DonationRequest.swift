//
//  DonationRequest.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 22/4/2564 BE.
//

import Foundation

struct DonationRequest: BaseRequest {
    let name: String
    let token: String
    let amount: Double
}
