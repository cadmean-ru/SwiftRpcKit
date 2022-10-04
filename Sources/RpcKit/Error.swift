//
//  File.swift
//  
//
//  Created by Алексей Крицков on 4/10/2565 BE.
//

import Foundation

public enum Error {
    case noError
    
    case functionNotCallable
    case functionNotFound
    case incompatibleVersion
    
    case invalidArguments
    
    case encodingError
    case decodingError
    
    case transportFailed
    case unsuccessfulStatusCode
    
    case serverError
    
    case unauthorized
    
    case preCallChecksFailed
    
    case niceError
    
    case custom(String)
}

extension Error : Codable, Equatable {
    public var code: String {
        get {
            switch self {
            case .functionNotCallable:
                return "function_not_callable"
            case .functionNotFound:
                return "function_not_found"
            case .incompatibleVersion:
                return "incompatible_rpc_version"
            case .invalidArguments:
                return "invalid_arguments"
            case .encodingError:
                return "encode_error"
            case .decodingError:
                return "decode_error"
            case .transportFailed:
                return "transport_error"
            case .unsuccessfulStatusCode:
                return "not_successful_status_code"
            case .serverError:
                return "internal_server_error"
            case .unauthorized:
                return "authorization_error"
            case .preCallChecksFailed:
                return "pre_call_checks_failed"
            case .niceError:
                return "nice_error"
            case .custom(let customCode):
                return customCode
            default:
                return ""
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        try code.encode(to: encoder)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if (container.decodeNil()) {
            self = .noError
            return
        }
        
        let value = try container.decode(String.self)
        
        switch value {
        case "":
            self = .noError
        case "function_not_callable":
            self = .functionNotCallable
        case "function_not_found":
            self = .functionNotFound
        case "incompatible_rpc_version":
            self = .incompatibleVersion
        case "invalid_arguments":
            self = .invalidArguments
        case "encode_error":
            self = .encodingError
        case "decode_error":
            self = .decodingError
        case "transport_error":
            self = .transportFailed
        case "not_successful_status_code":
            self = .unsuccessfulStatusCode
        case "internal_server_error":
            self = .serverError
        case "authorization_error":
            self = .unauthorized
        case "pre_call_checks_failed":
            self = .preCallChecksFailed
        case "nice_error":
            self = .niceError
        default:
            self = .custom(value)
        }
    }
}
