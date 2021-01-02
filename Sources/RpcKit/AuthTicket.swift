//
//  File.swift
//  
//
//  Created by Алексей Крицков on 02.01.2021.
//

import Foundation

public struct AuthTicket : Codable {
    public let accessToken: String?
    public let refreshToken: String?
}

public protocol AuthTicketHolder {
    var authTicket: AuthTicket? { get set }
}

public class TransientHolder : AuthTicketHolder {
    public var authTicket: AuthTicket?
}
