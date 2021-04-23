//
//  CharityDataResponse.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 24/4/2564 BE.
//

import Foundation

struct CharityDataResponse: Decodable {
    let id: Int
    let name: String
    let logoUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case logoUrl = "logo_url"
    }
}

//MARK: Transform
extension CharityDataResponse {
    var entity: CharityEntity {
        return CharityEntity(id: id,
                             name: name,
                             logoUrl: logoUrl)
    }
}
