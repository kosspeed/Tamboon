//
//  GetCharitiesUseCase.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 23/4/2564 BE.
//

import Foundation

protocol GetCharitiesUseCase {
    func execute(completion: @escaping (([CharityEntity]) -> Void), failure: @escaping ((ErrorEntity) -> Void))
}

class GetCharitiesUseCaseImpl: GetCharitiesUseCase {
    private let repository: OmiseRepository
    
    init(repository: OmiseRepository = OmiseRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (([CharityEntity]) -> Void), failure: @escaping ((ErrorEntity) -> Void)) {
        let request = CharityRequest()
        repository.getCharities(request: request, completion: completion, failure: failure)
    }
}
