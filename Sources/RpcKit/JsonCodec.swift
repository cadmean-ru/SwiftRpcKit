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
    
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    private static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone.init(secondsFromGMT: 0)
        formatter.locale = Locale.current
        return formatter
    }()
    
    init() {
        encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(JsonCodec.iso8601Full)
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(JsonCodec.iso8601Full)
    }
    
    public func encode<T: Encodable>(_ obj: T) -> Data? {
        guard let data = try? encoder.encode(obj) else {
            return nil
        }
        
        return data
    }
    
    public func decode<T: Decodable>(_ data: Data) -> T? {
        guard let obj = try? decoder.decode(T.self, from: data) else {
            return nil
        }
        
        return obj
    }
}
