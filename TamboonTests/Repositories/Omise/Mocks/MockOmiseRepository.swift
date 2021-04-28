//
//  MockOmiseRepository.swift
//  TamboonTests
//
//  Created by Khwan Siricharoenporn on 26/4/2564 BE.
//

import Foundation
@testable import Tamboon

final class MockOmiseRepositoryImpl: OmiseRepository {
    enum Result {
        case success
        case successWithFailure
        case failure
    }
    
    private let result: Result
    var countOfCallDonation: Int
    
    init(result: Result) {
        self.result = result
        countOfCallDonation = 0
    }
    
    func getCharities(request: CharityRequest, completion: @escaping (([CharityEntity]) -> Void), failure: @escaping ((ErrorEntity) -> Void)) {
        switch result {
        case .success:
            let entities = OmiseDataFactory.factory.charityResponse.data.map { $0.entity }
            completion(entities)
        case .failure:
            let error = OmiseDataFactory.factory.defaultErrorEntity
            failure(error)
        default:
            break
        }
    }
    
    func donation(request: DonationRequest, completion: @escaping (() -> Void), failure: @escaping ((ErrorEntity) -> Void)) {
        switch result {
        case .success:
            countOfCallDonation += 1
            completion()
        case .successWithFailure:
            let entity = OmiseDataFactory.factory.donationFailureResponse
            let error = OmiseDataFactory.factory.customErrorEntity(description: entity.errorMessage ?? "", code: 999)
            failure(error)
        case .failure:
            let error = OmiseDataFactory.factory.defaultErrorEntity
            failure(error)
        }
    }
}
