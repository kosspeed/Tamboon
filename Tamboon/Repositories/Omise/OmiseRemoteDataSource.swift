//
//  OmiseRemoteDataSource.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 22/4/2564 BE.
//

import Foundation
import Moya

protocol OmiseRemoteDataSource {
    func getCharities(request: CharityRequest, completion: @escaping (([CharityEntity]) -> Void), failure: @escaping ((ErrorEntity) -> Void))
    func donation(request: DonationRequest, completion: @escaping (() -> Void), failure: @escaping ((ErrorEntity) -> Void))
}

final class OmiseRemoteDataSourceImpl: OmiseRemoteDataSource {
    private let provider: MoyaProvider<OmiseAPI>
    
    init(provider: MoyaProvider<OmiseAPI> = MoyaProvider<OmiseAPI>(plugins: [VerbosePlugin(verbose: true)])) {
        self.provider = provider
    }
    
    func getCharities(request: CharityRequest, completion: @escaping (([CharityEntity]) -> Void), failure: @escaping ((ErrorEntity) -> Void)) {
        provider.requestWithWrappedSerialize(.charities(request: request), resposeType: CharityResponse.self) { (result) in
            switch result {
            case .success(let response):
                let entities = response.data.map { $0.entity }
                completion(entities)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func donation(request: DonationRequest, completion: @escaping (() -> Void), failure: @escaping ((ErrorEntity) -> Void)) {
        provider.requestWithWrappedSerialize(.donation(request: request), resposeType: DonationResponse.self) { (result) in
            switch result {
            case .success(let response):
                if response.success {
                    completion()
                } else {
                    let error = ErrorEntity(description: response.errorMessage ?? "", code: 999)
                    failure(error)
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    
}
