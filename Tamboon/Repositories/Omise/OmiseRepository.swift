//
//  OmiseRepository.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 22/4/2564 BE.
//

import Foundation

protocol OmiseRepository {
    func getCharities(request: CharityRequest, completion: @escaping (([CharityEntity]) -> Void), failure: @escaping ((ErrorEntity) -> Void))
    func donation(request: DonationRequest, completion: @escaping (() -> Void), failure: @escaping ((ErrorEntity) -> Void))
}

final class OmiseRepositoryImpl: OmiseRepository {
    private let remoteDataSource: OmiseRemoteDataSource
    
    init(remoteDataSource: OmiseRemoteDataSource = OmiseRemoteDataSourceImpl()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getCharities(request: CharityRequest, completion: @escaping (([CharityEntity]) -> Void), failure: @escaping ((ErrorEntity) -> Void)) {
        remoteDataSource.getCharities(request: request, completion: completion, failure: failure)
    }
    
    func donation(request: DonationRequest, completion: @escaping (() -> Void), failure: @escaping ((ErrorEntity) -> Void)) {
        remoteDataSource.donation(request: request, completion: completion, failure: failure)
    }
}
