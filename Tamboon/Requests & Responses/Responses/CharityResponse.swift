//
//  CharityResponse.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 22/4/2564 BE.
//

import Foundation

struct CharityResponse: Decodable {
    let id: Int
    let name: String
    let logoUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case logoUrl = "logo_url"
    }
}

//MARK: Transform
extension CharityResponse {
    var entity: Charity {
        return Charity(id: id,
                       name: name,
                       logoUrl: logoUrl)
    }
}
