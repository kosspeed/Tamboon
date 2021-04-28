//
//  MockGetCharitiesUseCase.swift
//  TamboonTests
//
//  Created by Khwan Siricharoenporn on 26/4/2564 BE.
//

import Foundation
@testable import Tamboon

class MockGetCharitiesUseCaseImpl: GetCharitiesUseCase {
    enum Result {
        case success
        case failure
    }
    
    private let result: Result
    
    init(result: Result) {
        self.result = result
    }
    
    func execute(completion: @escaping (([CharityEntity]) -> Void), failure: @escaping ((ErrorEntity) -> Void)) {
        switch result {
        case .success:
            let entities = OmiseDataFactory.factory.charityResponse.data.map { $0.entity }
            completion(entities)
        case .failure:
            let error = OmiseDataFactory.factory.defaultErrorEntity
            failure(error)
        }
    }
}
