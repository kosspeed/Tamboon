//
//  DonationUseCaseTests.swift
//  TamboonTests
//
//  Created by Khwan Siricharoenporn on 26/4/2564 BE.
//

import XCTest
@testable import Tamboon

class DonationUseCaseTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    func test_executeSuccess() {
        //arrange
        let repository = MockOmiseRepositoryImpl(result: .success)
        let useCase = DonationUseCaseImpl(repository: repository)
        
        //act
        useCase.execute(name: "", amount: 0.0, token: "", completion: {
            //assert
            XCTAssertEqual(repository.countOfCallDonation, 1)
        }, failure: { (error) in
            
        })
    }
    
    func test_executeSuccessWithFailure() {
        //arrange
        let repository = MockOmiseRepositoryImpl(result: .successWithFailure)
        let useCase = DonationUseCaseImpl(repository: repository)
        
        //act
        useCase.execute(name: "", amount: 0.0, token: "", completion: {
    
        }, failure: { (error) in
            //assert
            XCTAssertNotNil(error)
            XCTAssertEqual(error.description, "Card has insufficient balance.")
            XCTAssertEqual(error.code, 999)
        })
    }
    
    func test_executeFailure() {
        //arrange
        let repository = MockOmiseRepositoryImpl(result: .successWithFailure)
        let useCase = DonationUseCaseImpl(repository: repository)
        
        //act
        useCase.execute(name: "", amount: 0.0, token: "", completion: {
    
        }, failure: { (error) in
            //assert
            XCTAssertNotNil(error)
            XCTAssertEqual(error.code, 999)
        })
    }
}
