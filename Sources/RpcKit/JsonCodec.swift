//
//  File.swift
//  
//
//  Created by Алексей Крицков on 01.01.2021.
//

import Foundation

///JSON realization of codec protocol
public class JsonCodec: Codec {
    public var dataType: String = "application/json"
    
    public func encode<T: Encodable>(_ obj: T) -> Data? {
        guard let data = try? JSONEncoder().encode(obj) else {
            return nil
        }
        
        return data
    }
    
    public func decode<T: Decodable>(_ data: Data) -> T? {
        guard let obj = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        
        return obj
    }
}
