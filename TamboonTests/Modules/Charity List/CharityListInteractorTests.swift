//
//  CharityListInteractorTests.swift
//  TamboonTests
//
//  Created by Khwan Siricharoenporn on 28/4/2564 BE.
//

import XCTest
@testable import Tamboon

class CharityListInteractorTests: XCTestCase {
    var sut: CharityListInteractor!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_getCharitiesSuccess() {
        let presenterSpy = CharityListPresenterSpy()
        let useCase = MockGetCharitiesUseCaseImpl(result: .success)
        
        sut = CharityListInteractor(presenter: presenterSpy, useCase: useCase)
        sut.getCharities(request: .init())
        
        XCTAssertNotNil(presenterSpy.getCharitiesResponse)
        XCTAssertNotNil(presenterSpy.getCharitiesResponse?.charities)
        XCTAssert(presenterSpy.presentGetCharitiesCalled)
    }
    
    func test_getCharitiesFailure() {
        let presenterSpy = CharityListPresenterSpy()
        let useCase = MockGetCharitiesUseCaseImpl(result: .failure)
        
        sut = CharityListInteractor(presenter: presenterSpy, useCase: useCase)
        sut.getCharities(request: .init())
        
        XCTAssertNotNil(presenterSpy.getCharitiesResponse)
        XCTAssertNil(presenterSpy.getCharitiesResponse?.charities)
        XCTAssert(presenterSpy.presentGetCharitiesCalled)
    }
    
    func test_performDonation() {
        let presenterSpy = CharityListPresenterSpy()
        
        sut = CharityListInteractor(presenter: presenterSpy)
        sut.charities = OmiseDataFactory.factory.charityResponse.data.map { $0.entity }
        
        sut.performDonation(request: .init(charityId: 1))
        
        XCTAssertNotNil(presenterSpy.performDonationResponse)
        XCTAssertNotNil(presenterSpy.performDonationResponse?.charity)
        XCTAssertEqual(presenterSpy.performDonationResponse?.charity?.id, 1)
        XCTAssert(presenterSpy.presentPerformDonationCalled)
    }
}

//MARK: Spy
extension CharityListInteractorTests {
    class CharityListPresenterSpy: CharityListPresentable {
        var presentGetCharitiesCalled = false
        var presentPerformDonationCalled = false
        
        var getCharitiesResponse: CharityList.GetCharities.Response?
        var performDonationResponse: CharityList.PerformDonation.Response?
        
        func presentGetCharities(response: CharityList.GetCharities.Response) {
            presentGetCharitiesCalled = true
            getCharitiesResponse = response
        }
        
        func presentPerformDonation(response: CharityList.PerformDonation.Response) {
            presentPerformDonationCalled = true
            performDonationResponse = response
        }
    }
}
