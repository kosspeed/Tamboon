//
//  OmiseRepository.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 22/4/2564 BE.
//

import Foundation

protocol OmiseRepository {
    func getCharities(request: CharityRequest, completion: @escaping (([Charity]) -> Void), failure: @escaping ((Error) -> Void))
    func donation(request: DonationRequest, completion: @escaping (() -> Void), failure: @escaping ((Error) -> Void))
}

final class OmiseRepositoryImpl: OmiseRepository {
    private let remoteDataSource: OmiseRemoteDataSource
    
    init(remoteDataSource: OmiseRemoteDataSource = OmiseRemoteDataSourceImpl()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getCharities(request: CharityRequest, completion: @escaping (([Charity]) -> Void), failure: @escaping ((Error) -> Void)) {
        remoteDataSource.getCharities(request: request, completion: completion, failure: failure)
    }
    
    func donation(request: DonationRequest, completion: @escaping (() -> Void), failure: @escaping ((Error) -> Void)) {
        remoteDataSource.donation(request: request, completion: completion, failure: failure)
    }
}
