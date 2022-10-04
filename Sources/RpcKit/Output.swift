//
//  File.swift
//  
//
//  Created by Алексей Крицков on 01.01.2021.
//

import Foundation

struct Output<T : Decodable> : Decodable {
    let result: T?
    let error: Error
    let metaData: [String: String?]
    
    init(withError error: Error) {
        result = nil
        self.error = error
        metaData = [:]
    }
    
    init(withResult result: T) {
        self.result = result
        error = Error.noError
        metaData = [:]
    }
}
