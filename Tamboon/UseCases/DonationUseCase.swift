//
//  DonationUseCase.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 24/4/2564 BE.
//

import Foundation

protocol DonationUseCase {
    func donation(name: String, amount: Double, token: String, completion: @escaping (() -> Void), failure: @escaping ((ErrorEntity) -> Void))
}

class DonationUseCaseImpl: DonationUseCase {
    private let repository: OmiseRepository
    
    init(repository: OmiseRepository = OmiseRepositoryImpl()) {
        self.repository = repository
    }
    
    func donation(name: String, amount: Double, token: String, completion: @escaping (() -> Void), failure: @escaping ((ErrorEntity) -> Void)) {
        let request = DonationRequest(name: name,
                                      token: token,
                                      amount: amount)
        
        repository.donation(request: request, completion: completion, failure: failure)
    }
}
