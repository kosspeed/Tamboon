//
//  DonationPresenterTests.swift
//  TamboonTests
//
//  Created by Khwan Siricharoenporn on 28/4/2564 BE.
//

import XCTest
@testable import Tamboon

class DonationPresenterTests: XCTestCase {
    var sut: DonationPresenter!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_presentIntialize() {
        let displayableSpy = DonationDisplayableSpy()
        
        sut = DonationPresenter(displayable: displayableSpy)
        
        let charity = OmiseDataFactory.factory
            .charityResponse
            .data
            .map { $0.entity }
            .first
        
        sut.presentInitialize(response: .init(charity: charity))
        
        XCTAssertNotNil(displayableSpy.intiailizeViewModel)
        XCTAssertNotNil(displayableSpy.intiailizeViewModel?.charityName)
        XCTAssert(displayableSpy.displayInitializeCalled)
    }
    
    func test_presentPerformDonateCreditCardNumberIsEmpty() {
        let displayableSpy = DonationDisplayableSpy()
        
        sut = DonationPresenter(displayable: displayableSpy)
        sut.presentPerformDonate(response: .init(validate: .creditCardNumber))
        
        XCTAssertNotNil(displayableSpy.performDonateViewModel)
        XCTAssertNotNil(displayableSpy.performDonateViewModel?.error)
        XCTAssertEqual(displayableSpy.performDonateViewModel?.error?.description, "Please fill your credit card number.")
        XCTAssert(displayableSpy.displayPerformDonateCalled)
    }
    
    func test_presentPerformDonateCreditCardHolderIsEmpty() {
        let displayableSpy = DonationDisplayableSpy()
        
        sut = DonationPresenter(displayable: displayableSpy)
        sut.presentPerformDonate(response: .init(validate: .creditCardHolder))
        
        XCTAssertNotNil(displayableSpy.performDonateViewModel)
        XCTAssertNotNil(displayableSpy.performDonateViewModel?.error)
        XCTAssertEqual(displayableSpy.performDonateViewModel?.error?.description, "Please fill your holder person name.")
        XCTAssert(displayableSpy.displayPerformDonateCalled)
    }
    
    func test_presentPerformDonateCreditCardValidDateIsEmpty() {
        let displayableSpy = DonationDisplayableSpy()
        
        sut = DonationPresenter(displayable: displayableSpy)
        sut.presentPerformDonate(response: .init(validate: .creditCardValidDate))
        
        XCTAssertNotNil(displayableSpy.performDonateViewModel)
        XCTAssertNotNil(displayableSpy.performDonateViewModel?.error)
        XCTAssertEqual(displayableSpy.performDonateViewModel?.error?.description, "Please fill your valid date.")
        XCTAssert(displayableSpy.displayPerformDonateCalled)
    }
    
    func test_presentPerformDonateCreditCardCVVIsEmpty() {
        let displayableSpy = DonationDisplayableSpy()
        
        sut = DonationPresenter(displayable: displayableSpy)
        sut.presentPerformDonate(response: .init(validate: .creditCardCVV))
        
        XCTAssertNotNil(displayableSpy.performDonateViewModel)
        XCTAssertNotNil(displayableSpy.performDonateViewModel?.error)
        XCTAssertEqual(displayableSpy.performDonateViewModel?.error?.description, "Please fill your CVV.")
        XCTAssert(displayableSpy.displayPerformDonateCalled)
    }
    
    func test_presentPerformDonateAmountIsEmptyOrZero() {
        let displayableSpy = DonationDisplayableSpy()
        
        sut = DonationPresenter(displayable: displayableSpy)
        sut.presentPerformDonate(response: .init(validate: .amount))
        
        XCTAssertNotNil(displayableSpy.performDonateViewModel)
        XCTAssertNotNil(displayableSpy.performDonateViewModel?.error)
        XCTAssertEqual(displayableSpy.performDonateViewModel?.error?.description, "Please fill your amount.")
        XCTAssert(displayableSpy.displayPerformDonateCalled)
    }
    
    func test_presentPerformDonateFine() {
        let displayableSpy = DonationDisplayableSpy()
        
        sut = DonationPresenter(displayable: displayableSpy)
        sut.presentPerformDonate(response: .init(validate: .fine))
        
        XCTAssertNotNil(displayableSpy.performDonateViewModel)
        XCTAssertNotNil(displayableSpy.performDonateViewModel?.error)
        XCTAssertEqual(displayableSpy.performDonateViewModel?.error?.description, "")
        XCTAssert(displayableSpy.displayPerformDonateCalled)
    }
    
    func test_presentDonateSuccess() {
        let displayableSpy = DonationDisplayableSpy()
        
        sut = DonationPresenter(displayable: displayableSpy)
        sut.presentDonate(response: .init(status: .success, error: nil))
        
        XCTAssertNotNil(displayableSpy.donateViewModel)
        XCTAssertNil(displayableSpy.donateViewModel?.error)
        XCTAssert(displayableSpy.displayDonateCalled)
    }
    
    func test_presentDonateFailure() {
        let displayableSpy = DonationDisplayableSpy()
        
        sut = DonationPresenter(displayable: displayableSpy)
        
        let error = OmiseDataFactory.factory.defaultErrorEntity
        sut.presentDonate(response: .init(status: .failure, error: error))
        
        XCTAssertNotNil(displayableSpy.donateViewModel)
        XCTAssertNotNil(displayableSpy.donateViewModel?.error)
        XCTAssert(displayableSpy.displayDonateCalled)
    }
}

//MARK: Spy
extension DonationPresenterTests {
    class DonationDisplayableSpy: DonationDisplayable {
        var displayInitializeCalled = false
        var displayPerformDonateCalled = false
        var displayDonateCalled = false
        
        var intiailizeViewModel: Donation.Initialize.ViewModel?
        var performDonateViewModel: Donation.PerformDonate.ViewModel?
        var donateViewModel: Donation.Donate.ViewModel?
        
        func displayInitialize(viewModel: Donation.Initialize.ViewModel) {
            displayInitializeCalled = true
            intiailizeViewModel = viewModel
        }
        
        func displayPerformDonate(viewModel: Donation.PerformDonate.ViewModel) {
            displayPerformDonateCalled = true
            performDonateViewModel = viewModel
        }
        
        func displayDonate(viewModel: Donation.Donate.ViewModel) {
            displayDonateCalled = true
            donateViewModel = viewModel
        }
    }
}
