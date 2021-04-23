//
//  DonationResponse.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 23/4/2564 BE.
//

import Foundation

struct DonationResponse: Decodable {
    let success: Bool
    let errorCode: String?
    let errorMessage: String?
}
