public class RpcClient {
    public let serverUrl: String
    
    public init(at url: String) {
        serverUrl = url
    }
    
    public func function(of name: String) -> Function {
        return Function(name: name, client: self)
    }
}
