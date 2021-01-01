//
//  File.swift
//  
//
//  Created by Алексей Крицков on 01.01.2021.
//

import Foundation

///This protocol defines is used to encode and decode data before transfering it to the server.
public protocol Codec {
    func encode<T: Encodable>(_ obj: T) -> Data?
    func decode<T: Decodable>(_ data: Data) -> T?
    var dataType: String { get }
}
