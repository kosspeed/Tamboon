//
//  GetCharitiesUseCaseTests.swift
//  TamboonTests
//
//  Created by Khwan Siricharoenporn on 26/4/2564 BE.
//

import XCTest
@testable import Tamboon

class GetCharitiesUseCaseTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    func test_executeSuccess() {
        //arrange
        let repository = MockOmiseRepositoryImpl(result: .success)
        let useCase = GetCharitiesUseCaseImpl(repository: repository)
        
        //act
        useCase.execute(completion: { (charities) in
            //assert
            XCTAssertNotNil(charities)
            XCTAssertEqual(charities.count, 4)
        }, failure: { (error) in
            
        })
    }
    
    func test_executeFailure() {
        //arrange
        let repository = MockOmiseRepositoryImpl(result: .failure)
        let useCase = GetCharitiesUseCaseImpl(repository: repository)
        
        //act
        useCase.execute(completion: { (charities) in
    
        }, failure: { (error) in
            //assert
            XCTAssertNotNil(error)
            XCTAssertEqual(error.code, 999)
        })
    }
}
