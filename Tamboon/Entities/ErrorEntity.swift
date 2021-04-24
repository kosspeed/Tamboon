//
//  ErrorEntity.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 23/4/2564 BE.
//

import Foundation
import Moya

fileprivate let kDefaultErrorCode: Int = 999

struct ErrorEntity: Error {
    let description: String
    let code: Int
    
    init(description: String, code: Int) {
        self.description = description
        self.code = code
    }
    
    init(from error: Error) {
        description = error.localizedDescription
        code = kDefaultErrorCode
    }
    
    init(from moyaError: MoyaError) {
        description = moyaError.localizedDescription
        code = moyaError.response?.statusCode ?? kDefaultErrorCode
    }
}
