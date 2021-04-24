//
//  OmiseAPI.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 22/4/2564 BE.
//

import Foundation
import Moya

enum OmiseAPI {
    case charities(request: CharityRequest)
    case donation(request: DonationRequest)
}

//MARK: TargetType
extension OmiseAPI: TargetType {
    var baseURL: URL {
        let config: Config
        
        switch self {
        case .charities(let request):
            config = request.config
        case .donation(let request):
            config = request.config
        }
        
        return URL(string: config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .charities:
            return "/tamboon-api/1.0.0/charities"
        case .donation:
            return "/tamboon-api/1.0.0/donations"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .charities:
            return .get
        case .donation:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .charities:
            return .requestPlain
        case .donation(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
