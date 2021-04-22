//
//  Moya+Extensions.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 23/4/2564 BE.
//

import Foundation
import Moya

extension MoyaProvider {
    func requestWithWrappedSerialize<R: Decodable>(_ target: Target,
                                                   resposeType: R.Type,
                                                   completion: @escaping (Result<R, ErrorEntity>) -> Void) {
        request(target) { (result) in
            switch result {
            case .success(let response):
                do {
                    let wrappedResponse = try response.data.jsonTo(type: resposeType)
                    completion(.success(wrappedResponse))
                } catch (let error) {
                    let error = ErrorEntity(from: error)
                    completion(.failure(error))
                }
            case .failure(let error):
                let error = ErrorEntity(from: error)
                completion(.failure(error))
            }
        }
    }
}
