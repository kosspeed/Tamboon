//
//  CharityResponse.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 22/4/2564 BE.
//

import Foundation

struct CharityResponse: Decodable {
    let total: Int
    let data: [CharityDataResponse]
}
