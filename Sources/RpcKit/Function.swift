//
//  File.swift
//  
//
//  Created by Алексей Крицков on 01.01.2021.
//

import Foundation

public class Function {
    let name: String
    private let client: RpcClient
    
    init(name: String, client: RpcClient) {
        self.name = name
        self.client = client
    }
    
    public func call<T: Decodable>(with args: Argument..., onResult callback: @escaping (T?, Error) -> Void) {
        let call = Call(args: args, auth: "")
        
        guard let data = client.codec.encode(call) else { callback(nil, .encodingError); return }
        
        client.transportProvider.send(data: data, ofType: client.codec.dataType, at: client.serverUrl + "/api/rpc/" + name) { respData, err in
            if err != .noError {
                callback(nil, err)
                return
            }
            
            guard let output: Output<T> = self.client.codec.decode(respData!) else { callback(nil, .decodingError); return }
            
            callback(output.result, output.error)
        }
    }
}
