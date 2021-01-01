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

public enum Error {
    case noError// = 0
    
    case functionNotCallable// = -100
    case functionNotFound// = -101
    case incompatibleVersion// = -102
    
    case invalidArguments// = -200
    
    case encodingError //= -300
    case decodingError //= -301
    
    case transportFailed //= -400
    case unsuccessfulStatusCode //= -401
    
    case serverError //= -500
    
    case unauthorized //= -600
    
    case preCallChecksFailed //= -700
    
    case niceError //= -69
    
    case custom(Int)
}

extension Error : Codable, Equatable {
    public var code: Int {
        get {
            switch self {
            case .functionNotCallable:
                return -100
            case .functionNotFound:
                return -101
            case .incompatibleVersion:
                return -102
            case .invalidArguments:
                return -200
            case .encodingError:
                return -300
            case .decodingError:
                return -301
            case .transportFailed:
                return -400
            case .unsuccessfulStatusCode:
                return -401
            case .serverError:
                return -500
            case .unauthorized:
                return -600
            case .preCallChecksFailed:
                return -700
            case .niceError:
                return -69
            case .custom(let customCode):
                return customCode
            default:
                return 0
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        try code.encode(to: encoder)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(Int.self)
        
        switch value {
        case 0:
            self = .noError
        case -100:
            self = .functionNotCallable
        case -101:
            self = .functionNotFound
        case -102:
            self = .incompatibleVersion
        case -200:
            self = .invalidArguments
        case -300:
            self = .encodingError
        case -301:
            self = .decodingError
        case -400:
            self = .transportFailed
        case -401:
            self = .unsuccessfulStatusCode
        case -500:
            self = .serverError
        case -600:
            self = .unauthorized
        case -700:
            self = .preCallChecksFailed
        case -69:
            self = .niceError
        default:
            self = .custom(value)
        }
    }
}
