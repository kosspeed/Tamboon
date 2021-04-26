//
//  OmiseRemoteDataSourceTests.swift
//  TamboonTests
//
//  Created by Khwan Siricharoenporn on 26/4/2564 BE.
//

import XCTest
import Moya
@testable import Tamboon

class OmiseRemoteDataSourceTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    func test_getCharitiesAPISuccess() {
        //arrange
        guard let data = Bundle.loadDataInJSONFile(fileName: "charities", type: type(of: self)) else {
            XCTFail()
            
            return
        }
        
        let provider = MockMoyaProvider<OmiseAPI>(endpointClosure: {
            $0.endpointForAPI(response: .networkResponse(200, data))
        }, stubClosure: { _ in
            .immediate
        })
        
        let remoteDataSource = OmiseRemoteDataSourceImpl(provider: provider)
        
        //act
        remoteDataSource.getCharities(request: OmiseDataFactory.factory.charityRequest, completion: { (charities) in
            //assert
            XCTAssertNotNil(charities)
            XCTAssertEqual(charities.count, 4)
            XCTAssertEqual(provider.countOfCallRequest, 1)
        }, failure: { (error) in
            
        })
    }
    
    func test_getCharitiesAPIEmpty() {
        //arrange
        guard let data = Bundle.loadDataInJSONFile(fileName: "charities_empty", type: type(of: self)) else {
            XCTFail()
            
            return
        }
        
        let provider = MockMoyaProvider<OmiseAPI>(endpointClosure: {
            $0.endpointForAPI(response: .networkResponse(200, data))
        }, stubClosure: { _ in
            .immediate
        })
        
        let remoteDataSource = OmiseRemoteDataSourceImpl(provider: provider)
        
        //act
        remoteDataSource.getCharities(request: OmiseDataFactory.factory.charityRequest, completion: { (charities) in
            //assert
            XCTAssertNotNil(charities)
            XCTAssertEqual(charities.count, 0)
            XCTAssertEqual(provider.countOfCallRequest, 1)
        }, failure: { (error) in
            
        })
    }
    
    func test_getCharitiesAPIFailure() {
        //arrange
        let error = OmiseDataFactory.factory.defaultErrorEntity as NSError
        
        let provider = MockMoyaProvider<OmiseAPI>(endpointClosure: {
            $0.endpointForAPI(response: .networkError(error))
        }, stubClosure: { _ in
            .immediate
        })
        
        let remoteDataSource = OmiseRemoteDataSourceImpl(provider: provider)
        
        //act
        remoteDataSource.getCharities(request: OmiseDataFactory.factory.charityRequest, completion: { (charities) in
            
        }, failure: { (error) in
            //assert
            XCTAssertNotNil(error)
        })
    }
    
    func test_donationAPISuccess() {
        //arrange
        guard let data = Bundle.loadDataInJSONFile(fileName: "donation_success", type: type(of: self)) else {
            XCTFail()
            
            return
        }
        
        let provider = MockMoyaProvider<OmiseAPI>(endpointClosure: {
            $0.endpointForAPI(response: .networkResponse(200, data))
        }, stubClosure: { _ in
            .immediate
        })
        
        let remoteDataSource = OmiseRemoteDataSourceImpl(provider: provider)
        
        //act
        remoteDataSource.donation(request: OmiseDataFactory.factory.donationRequest, completion: {
            //assert
            XCTAssertEqual(provider.countOfCallRequest, 1)
        }, failure: { (error) in
            
        })
    }
    
    func test_donationAPIFailure() {
        //arrange
        guard let data = Bundle.loadDataInJSONFile(fileName: "donation_failure", type: type(of: self)) else {
            XCTFail()
            
            return
        }
        
        let provider = MockMoyaProvider<OmiseAPI>(endpointClosure: {
            $0.endpointForAPI(response: .networkResponse(200, data))
        }, stubClosure: { _ in
            .immediate
        })
        
        let remoteDataSource = OmiseRemoteDataSourceImpl(provider: provider)
        
        //act
        remoteDataSource.donation(request: OmiseDataFactory.factory.donationRequest, completion: {
            
        }, failure: { (error) in
            //assert
            XCTAssertNotNil(error)
            XCTAssertEqual(error.description, "Card has insufficient balance.")
            XCTAssertEqual(error.code, 999)
        })
    }
    
    func test_donationAPIFailure400() {
        //arrange
        let error = OmiseDataFactory.factory.defaultErrorEntity as NSError
        
        let provider = MockMoyaProvider<OmiseAPI>(endpointClosure: {
            $0.endpointForAPI(response: .networkError(error))
        }, stubClosure: { _ in
            .immediate
        })
        
        let remoteDataSource = OmiseRemoteDataSourceImpl(provider: provider)
        
        //act
        remoteDataSource.donation(request: OmiseDataFactory.factory.donationRequest, completion: {
            
        }, failure: { (error) in
            //assert
            XCTAssertNotNil(error)
            XCTAssertEqual(error.code, 999)
        })
    }
}
