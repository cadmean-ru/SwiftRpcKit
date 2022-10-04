///This is the main class for making RPC calls
public class RpcClient {
    public let serverUrl: String
    
    public var transportProvider: TransportProvider = HttpTransportProvider()
    public var codec: Codec = JsonCodec()
    public var authTicketHolder: AuthTicketHolder = TransientHolder()
    
    public init(at url: String) {
        serverUrl = url
    }
    
    public func function(named name: String) -> Function {
        return Function(name: name, client: self)
    }
}
