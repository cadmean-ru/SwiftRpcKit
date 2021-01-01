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
        guard let callJson = try? JSONEncoder().encode(call) else { callback(nil, .encodingError); return }
        
        let url = URL(string: client.serverUrl + "/api/rpc/" + name)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("2.1", forHTTPHeaderField: "Cadmean-RPC-Version")
        request.httpBody = callJson
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if (error != nil) {
                callback(nil, .transportFailed)
                return
            }
            
            guard let response = response as? HTTPURLResponse, let data = data else { callback(nil, .transportFailed); return }
            
            if (response.statusCode != 200) {
                callback(nil, .unsuccessfulStatusCode)
                return
            }
            
            guard let output = try? JSONDecoder().decode(Output<T>.self, from: data) else { callback(nil, .decodingError); return }
            callback(output.result, output.error)
        }
        
        task.resume()
    }
}
