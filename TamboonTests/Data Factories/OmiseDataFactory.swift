//
//  OmiseDataFactory.swift
//  TamboonTests
//
//  Created by Khwan Siricharoenporn on 26/4/2564 BE.
//

import Foundation
@testable import Tamboon

class OmiseDataFactory {
    static let factory: OmiseDataFactory = OmiseDataFactory()
    
    private init() {}
    
    var charityRequest: CharityRequest {
        return CharityRequest()
    }
    
    var charityResponse: CharityResponse {
        let data = Bundle.loadDataInJSONFile(fileName: "charities", type: type(of: self))
        let decoded = try! JSONDecoder().decode(CharityResponse.self, from: data!)
        return decoded
    }
    
    var charityEmptyResponse: CharityResponse {
        let data = Bundle.loadDataInJSONFile(fileName: "charities_empty", type: type(of: self))
        let decoded = try! JSONDecoder().decode(CharityResponse.self, from: data!)
        return decoded
    }
    
    var donationRequest: DonationRequest {
        return DonationRequest(name: "John Doe",
                               token: "test",
                               amount: 1234)
    }
    
    var donationSuccessResponse: DonationResponse {
        let data = Bundle.loadDataInJSONFile(fileName: "donation_success", type: type(of: self))
        let decoded = try! JSONDecoder().decode(DonationResponse.self, from: data!)
        return decoded
    }
    
    var donationFailureResponse: DonationResponse {
        let data = Bundle.loadDataInJSONFile(fileName: "donation_failure", type: type(of: self))
        let decoded = try! JSONDecoder().decode(DonationResponse.self, from: data!)
        return decoded
    }
    
    var defaultErrorEntity: ErrorEntity {
        return ErrorEntity(description: "Error", code: 999)
    }
    
    func customErrorEntity(description: String, code: Int) -> ErrorEntity {
        return ErrorEntity(description: description, code: code)
    }
}
