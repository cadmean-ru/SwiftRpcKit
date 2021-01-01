//
//  File.swift
//  
//
//  Created by Алексей Крицков on 01.01.2021.
//

import Foundation

///Protocal used to send data from client to server and back.
public protocol TransportProvider {
    func send(data: Data, ofType type: String, at url: String, onFinish callback: @escaping (Data?, Error) -> Void)
}
