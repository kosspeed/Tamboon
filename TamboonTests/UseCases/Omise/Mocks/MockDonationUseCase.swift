//
//  MockDonationUseCase.swift
//  TamboonTests
//
//  Created by Khwan Siricharoenporn on 26/4/2564 BE.
//

import Foundation
@testable import Tamboon

class MockDonationUseCase: DonationUseCase {
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
    
    func execute(name: String, amount: Double, token: String, completion: @escaping (() -> Void), failure: @escaping ((ErrorEntity) -> Void)) {
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
