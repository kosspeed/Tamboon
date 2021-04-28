//
//  Config.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 22/4/2564 BE.
//

import Foundation

fileprivate let kBaseURLKey: String = "BASE_URL"
fileprivate let kURLTokenAPIKey: String = "API_TOKEN"

struct Config {
    static var `default`: Config = Config()
    
    private(set) var baseURL: String
    private(set) var apiToken: String
    private(set) var backupApiToken: String
    
    init(type: ConfigType = .default) {
        switch type {
        case .default:
            let plist = Bundle.getPlist(forResource: "Config")
            
            baseURL = plist?[kBaseURLKey] as? String ?? ""
            apiToken = plist?[kURLTokenAPIKey] as? String ?? ""
            backupApiToken = apiToken
        case .customize(let baseURL, let apiToken):
            self.baseURL = baseURL
            self.apiToken = apiToken
            backupApiToken = apiToken
        }
    }
    
    mutating func executeThenRevertToken(newToken token: String, handler: (() -> Void)? = nil) {
        apiToken = token
        handler?()
        apiToken = backupApiToken
    }
}

//MARK: ConfigType
extension Config {
    enum ConfigType {
        case `default`
        case customize(baseURL: String, apiToken: String)
    }
}
