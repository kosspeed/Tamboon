//
//  BaseRequest.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 22/4/2564 BE.
//

import Foundation

class BaseRequest: Requestable, Encodable {
    var config: Config { return .default }
}
