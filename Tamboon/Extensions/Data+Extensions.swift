//
//  Data+Extensions.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 23/4/2564 BE.
//

import Foundation

extension Data {
    func jsonTo<T: Decodable>(type: T.Type) throws -> T {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: self)
        }
        catch let error {
            debugPrint("JSONDecoder Failure: \(error.localizedDescription)")
            
            throw error
        }
    }
}
