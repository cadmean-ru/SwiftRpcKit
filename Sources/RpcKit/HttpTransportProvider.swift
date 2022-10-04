//
//  File.swift
//  
//
//  Created by Алексей Крицков on 01.01.2021.
//

import Foundation

public class HttpTransportProvider: TransportProvider {
    public func send(data: Data, ofType type: String, at url: String, onFinish callback: @escaping (Data?, Error) -> Void) {
        let url1 = URL(string: url)!
        
        var request = URLRequest(url: url1)
        request.httpMethod = "POST"
        request.setValue("3.0", forHTTPHeaderField: "Cadmean-RPC-Version")
        request.setValue(type, forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        let task = URLSession.shared.dataTask(with: request) { respData, resp, error in
            if (error != nil) {
                callback(nil, .transportFailed)
                return
            }
            
            guard let resp = resp as? HTTPURLResponse, let respData = respData else { callback(nil, .transportFailed); return }
        
            if (resp.statusCode != 200) {
                callback(nil, .unsuccessfulStatusCode)
                return
            }
            
            callback(respData, .noError)
        }
        
        task.resume()
    }
}
