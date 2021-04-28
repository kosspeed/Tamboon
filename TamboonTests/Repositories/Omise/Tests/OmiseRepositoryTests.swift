//
//  OmiseRepositoryTests.swift
//  TamboonTests
//
//  Created by Khwan Siricharoenporn on 26/4/2564 BE.
//

import XCTest
@testable import Tamboon

class OmiseRepositoryTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    func test_getCharitiesSuccess() {
        //arrange
        let remoteDataSource = MockOmiseRemoteDataSourceImpl(result: .success)
        let repository = OmiseRepositoryImpl(remoteDataSource: remoteDataSource)
        
        //act
        repository.getCharities(request: OmiseDataFactory.factory.charityRequest, completion: { (charities) in
            //assert
            XCTAssertNotNil(charities)
            XCTAssertEqual(charities.count, 4)
        }, failure: { (error) in
            
        })
    }
    
    func test_getCharitiesFailure() {
        //arrange
        let remoteDataSource = MockOmiseRemoteDataSourceImpl(result: .failure)
        let repository = OmiseRepositoryImpl(remoteDataSource: remoteDataSource)
        
        //act
        repository.getCharities(request: OmiseDataFactory.factory.charityRequest, completion: { (charities) in
        }, failure: { (error) in
            //assert
            XCTAssertNotNil(error)
        })
    }
    
    func test_donationSuccess() {
        //arrange
        let remoteDataSource = MockOmiseRemoteDataSourceImpl(result: .success)
        let repository = OmiseRepositoryImpl(remoteDataSource: remoteDataSource)
        
        //act
        repository.donation(request: OmiseDataFactory.factory.donationRequest, completion: {
            //assert
            XCTAssertEqual(remoteDataSource.countOfCallDonation, 1)
        }, failure: { (error) in
            
        })
    }
    
    func test_donationSuccessWithFailure() {
        //arrange
        let remoteDataSource = MockOmiseRemoteDataSourceImpl(result: .successWithFailure)
        let repository = OmiseRepositoryImpl(remoteDataSource: remoteDataSource)
        
        //act
        repository.donation(request: OmiseDataFactory.factory.donationRequest, completion: {
            
        }, failure: { (error) in
            //assert
            XCTAssertNotNil(error)
            XCTAssertEqual(error.description, "Card has insufficient balance.")
            XCTAssertEqual(error.code, 999)
        })
    }
    
    func test_donationFailure() {
        //arrange
        let remoteDataSource = MockOmiseRemoteDataSourceImpl(result: .failure)
        let repository = OmiseRepositoryImpl(remoteDataSource: remoteDataSource)
        
        //act
        repository.donation(request: OmiseDataFactory.factory.donationRequest, completion: {
            
        }, failure: { (error) in
            //assert
            XCTAssertNotNil(error)
            XCTAssertEqual(error.description, "Error")
            XCTAssertEqual(error.code, 999)
        })
    }
}
