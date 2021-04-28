//
//  CharityListPresenterTests.swift
//  TamboonTests
//
//  Created by Khwan Siricharoenporn on 28/4/2564 BE.
//

import XCTest
@testable import Tamboon

class CharityListPresenterTests: XCTestCase {
    var sut: CharityListPresenter!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_presentGetCharitiesSuccess() {
        let displayableSpy = CharityListDisplayableSpy()
        
        sut = CharityListPresenter(displayable: displayableSpy)
        
        let charities = OmiseDataFactory.factory.charityResponse.data.map { $0.entity }
        
        sut.presentGetCharities(response: .init(status: .success, charities: charities, error: nil))
        
        XCTAssertNotNil(displayableSpy.getCharitiesViewModel)
        XCTAssertNotNil(displayableSpy.getCharitiesViewModel?.charities)
        XCTAssert(displayableSpy.displayGetCharitiesCalled)
    }
    
    func test_presentGetCharitiesFailure() {
        let displayableSpy = CharityListDisplayableSpy()
        
        sut = CharityListPresenter(displayable: displayableSpy)
        
        let error = OmiseDataFactory.factory.defaultErrorEntity
        sut.presentGetCharities(response: .init(status: .failure, charities: nil, error: error))
        
        XCTAssertNotNil(displayableSpy.getCharitiesViewModel)
        XCTAssertNotNil(displayableSpy.getCharitiesViewModel?.error)
        XCTAssert(displayableSpy.displayGetCharitiesCalled)
    }
    
    func test_presentPerformDonation() {
        let displayableSpy = CharityListDisplayableSpy()
        
        sut = CharityListPresenter(displayable: displayableSpy)
        
        let charity = OmiseDataFactory.factory
            .charityResponse
            .data
            .map { $0.entity }
            .first
        
        sut.presentPerformDonation(response: .init(charity: charity))
        
        XCTAssertNotNil(displayableSpy.performDonationViewModel)
        XCTAssertNotNil(displayableSpy.performDonationViewModel?.charity)
        XCTAssert(displayableSpy.displayPerformDonationCalled)
    }
}

//MARK: Spy
extension CharityListPresenterTests {
    class CharityListDisplayableSpy: CharityListDisplayable {
        var displayGetCharitiesCalled = false
        var displayPerformDonationCalled = false
        
        var getCharitiesViewModel: CharityList.GetCharities.ViewModel?
        var performDonationViewModel: CharityList.PerformDonation.ViewModel?
        
        func displayGetCharities(viewModel: CharityList.GetCharities.ViewModel) {
            displayGetCharitiesCalled = true
            getCharitiesViewModel = viewModel
        }
        
        func displayPerformDonation(viewModel: CharityList.PerformDonation.ViewModel) {
            displayPerformDonationCalled = true
            performDonationViewModel = viewModel
        }
    }
}
