//
//  Delegate.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 23/4/2564 BE.
//

import Foundation

struct Delegated<Input> {
    private(set) var callback: ((Input) -> Void)?
    
    mutating func delegate<Object : AnyObject>(
        to object: Object,
        with callback: @escaping (Object, Input) -> Void) {
        self.callback = { [weak object] input in
            guard let object = object else {
                return
            }
            
            callback(object, input)
        }
    }
}
