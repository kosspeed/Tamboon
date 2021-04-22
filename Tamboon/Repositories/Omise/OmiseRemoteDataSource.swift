//
//  OmiseRemoteDataSource.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 22/4/2564 BE.
//

import Foundation
import Moya

protocol OmiseRemoteDataSource {
    func getCharities(request: CharityRequest, completion: @escaping (([Charity]) -> Void), failure: @escaping ((Error) -> Void))
    func donation(request: DonationRequest, completion: @escaping (() -> Void), failure: @escaping ((Error) -> Void))
}

final class OmiseRemoteDataSourceImpl: OmiseRemoteDataSource {
    private let provider: MoyaProvider<OmiseAPI>
    
    init(provider: MoyaProvider<OmiseAPI> = MoyaProvider<OmiseAPI>()) {
        self.provider = provider
    }
    
    func getCharities(request: CharityRequest, completion: @escaping (([Charity]) -> Void), failure: @escaping ((Error) -> Void)) {
        provider.request(.charities(request: request)) { (result) in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                let decoded = try? decoder.decode([CharityResponse].self, from: response.data)
                let entities = decoded?.map { $0.entity } ?? []
                
                completion(entities)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func donation(request: DonationRequest, completion: @escaping (() -> Void), failure: @escaping ((Error) -> Void)) {
        provider.request(.donation(request: request)) { (result) in
            switch result {
            case .success:
                completion()
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    
}
