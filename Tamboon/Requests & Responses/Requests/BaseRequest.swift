//
//  BaseRequest.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 22/4/2564 BE.
//

import Foundation

protocol BaseRequest: Requestable, Encodable {
    var config: Config { get }
}

extension BaseRequest {
    var config: Config {
        return .default
    }
}
