//
//  DonationInteractorTests.swift
//  TamboonTests
//
//  Created by Khwan Siricharoenporn on 28/4/2564 BE.
//

import XCTest
@testable import Tamboon

class DonationInteractorTests: XCTestCase {
    var sut: DonationInteractor!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_intialize() {
        let presenterSpy = DonationPresenterSpy()
        
        sut = DonationInteractor(presenter: presenterSpy)
        
        let charity = OmiseDataFactory.factory
            .charityResponse
            .data
            .map { $0.entity }
            .first
        
        sut.charity = charity
        sut.initialize(request: .init())
        
        XCTAssertNotNil(presenterSpy.initializeResponse)
        XCTAssertNotNil(presenterSpy.initializeResponse?.charity)
        XCTAssert(presenterSpy.presentInitializeCalled)
    }
    
    func test_performDonateCreditCardNumberIsEmpty() {
        let presenterSpy = DonationPresenterSpy()
        
        sut = DonationInteractor(presenter: presenterSpy)
        sut.performDonate(request: .init(creditCardNumber: "",
                                         creditCardHolder: nil,
                                         creditCardValidDate: nil,
                                         creditCardCVV: nil,
                                         amount: nil))
        
        XCTAssertNotNil(presenterSpy.performDonateResponse)
        XCTAssertNotNil(presenterSpy.performDonateResponse?.validate)
        XCTAssertEqual(presenterSpy.performDonateResponse?.validate, .creditCardNumber)
        XCTAssert(presenterSpy.presentPerformDonateCalled)
    }
    
    func test_performDonateCreditCardHolderIsEmpty() {
        let presenterSpy = DonationPresenterSpy()
        
        sut = DonationInteractor(presenter: presenterSpy)
        sut.performDonate(request: .init(creditCardNumber: nil,
                                         creditCardHolder: "",
                                         creditCardValidDate: nil,
                                         creditCardCVV: nil,
                                         amount: nil))
        
        XCTAssertNotNil(presenterSpy.performDonateResponse)
        XCTAssertNotNil(presenterSpy.performDonateResponse?.validate)
        XCTAssertEqual(presenterSpy.performDonateResponse?.validate, .creditCardHolder)
        XCTAssert(presenterSpy.presentPerformDonateCalled)
    }
    
    func test_performDonateCreditCardValidDateIsEmpty() {
        let presenterSpy = DonationPresenterSpy()
        
        sut = DonationInteractor(presenter: presenterSpy)
        sut.performDonate(request: .init(creditCardNumber: nil,
                                         creditCardHolder: nil,
                                         creditCardValidDate: "",
                                         creditCardCVV: nil,
                                         amount: nil))
        
        XCTAssertNotNil(presenterSpy.performDonateResponse)
        XCTAssertNotNil(presenterSpy.performDonateResponse?.validate)
        XCTAssertEqual(presenterSpy.performDonateResponse?.validate, .creditCardValidDate)
        XCTAssert(presenterSpy.presentPerformDonateCalled)
    }
    
    func test_performDonateCreditCardCVVIsEmpty() {
        let presenterSpy = DonationPresenterSpy()
        
        sut = DonationInteractor(presenter: presenterSpy)
        sut.performDonate(request: .init(creditCardNumber: nil,
                                         creditCardHolder: nil,
                                         creditCardValidDate: nil,
                                         creditCardCVV: "",
                                         amount: nil))
        
        XCTAssertNotNil(presenterSpy.performDonateResponse)
        XCTAssertNotNil(presenterSpy.performDonateResponse?.validate)
        XCTAssertEqual(presenterSpy.performDonateResponse?.validate, .creditCardCVV)
        XCTAssert(presenterSpy.presentPerformDonateCalled)
    }
    
    func test_performDonateAmountIsEmpty() {
        let presenterSpy = DonationPresenterSpy()
        
        sut = DonationInteractor(presenter: presenterSpy)
        sut.performDonate(request: .init(creditCardNumber: nil,
                                         creditCardHolder: nil,
                                         creditCardValidDate: nil,
                                         creditCardCVV: nil,
                                         amount: ""))
        
        XCTAssertNotNil(presenterSpy.performDonateResponse)
        XCTAssertNotNil(presenterSpy.performDonateResponse?.validate)
        XCTAssertEqual(presenterSpy.performDonateResponse?.validate, .amount)
        XCTAssert(presenterSpy.presentPerformDonateCalled)
    }
    
    func test_performDonateAmountIsZero() {
        let presenterSpy = DonationPresenterSpy()
        
        sut = DonationInteractor(presenter: presenterSpy)
        sut.performDonate(request: .init(creditCardNumber: nil,
                                         creditCardHolder: nil,
                                         creditCardValidDate: nil,
                                         creditCardCVV: nil,
                                         amount: "0"))
        
        XCTAssertNotNil(presenterSpy.performDonateResponse)
        XCTAssertNotNil(presenterSpy.performDonateResponse?.validate)
        XCTAssertEqual(presenterSpy.performDonateResponse?.validate, .amount)
        XCTAssert(presenterSpy.presentPerformDonateCalled)
    }
    
    func test_donateSuccess() {
        let presenterSpy = DonationPresenterSpy()
        let useCase = MockDonationUseCase(result: .success)
        let config = Config(type: .customize(baseURL: "", apiToken: ""))
        
        sut = DonationInteractor(presenter: presenterSpy,
                                 config: config,
                                 useCase: useCase)
        sut.donate(request: .init(creditCardNumber: "",
                                  creditCardHolder: "",
                                  creditCardValidDate: "",
                                  creditCardCVV: "",
                                  amount: ""))
        
        XCTAssertNotNil(presenterSpy.donateResponse)
        XCTAssertEqual(presenterSpy.donateResponse?.status, .success)
        XCTAssert(presenterSpy.presentDonateCalled)
    }
    
    func test_donateFailure() {
        let presenterSpy = DonationPresenterSpy()
        let useCase = MockDonationUseCase(result: .failure)
        let config = Config(type: .customize(baseURL: "", apiToken: ""))
        
        sut = DonationInteractor(presenter: presenterSpy,
                                 config: config,
                                 useCase: useCase)
        sut.donate(request: .init(creditCardNumber: "",
                                  creditCardHolder: "",
                                  creditCardValidDate: "",
                                  creditCardCVV: "",
                                  amount: ""))
        
        XCTAssertNotNil(presenterSpy.donateResponse)
        XCTAssertEqual(presenterSpy.donateResponse?.status, .failure)
        XCTAssert(presenterSpy.presentDonateCalled)
    }
}

//MARK: Spy
extension DonationInteractorTests {
    class DonationPresenterSpy: DonationPresentable {
        var presentInitializeCalled = false
        var presentPerformDonateCalled = false
        var presentDonateCalled = false
        
        var initializeResponse: Donation.Initialize.Response?
        var performDonateResponse: Donation.PerformDonate.Response?
        var donateResponse: Donation.Donate.Response?
        
        func presentInitialize(response: Donation.Initialize.Response) {
            presentInitializeCalled = true
            initializeResponse = response
        }
        
        func presentPerformDonate(response: Donation.PerformDonate.Response) {
            presentPerformDonateCalled = true
            performDonateResponse = response
        }
        
        func presentDonate(response: Donation.Donate.Response) {
            presentDonateCalled = true
            donateResponse = response
        }
    }
}
