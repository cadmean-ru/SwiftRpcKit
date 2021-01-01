//
//  File.swift
//  
//
//  Created by Алексей Крицков on 01.01.2021.
//

import Foundation

struct Call : Encodable {
    let args: [Argument]
    let auth: String
}

public struct Argument : Encodable {
    public let value: Any
    private let _encode: (Encoder) throws -> Void
    
    public init<T: Encodable>(of wrapped: T) {
        value = wrapped
        _encode = wrapped.encode
    }
    
    public func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
