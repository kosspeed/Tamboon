//
//  Bundle+Extensions.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 22/4/2564 BE.
//

import Foundation

extension Bundle {
    static func getPlist(inBundle bundle: Bundle = .main,
                         forResource resource: String) -> [String: Any]? {
        guard let path = bundle.path(forResource: resource, ofType: "plist") else {
            return nil
        }
        
        return NSDictionary(contentsOfFile: path) as? [String: Any]
    }
    
    static func plistValue(inBundle bundle: Bundle = .main,
                           forResource resource: String,
                           forKey key: String) -> Any? {
        guard let resource = getPlist(inBundle: bundle, forResource: resource) else {
            return nil
        }
        
        return resource[key]
    }
}
