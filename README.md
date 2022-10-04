# cadRPC client library for Swift

cadRPC is an easy-to-use RPC technology. It's goal is to simplify the communication with your web API, hiding all the HTTP and JSON stuff.

## Installation

TODO

## How to use

```swift
import RpcKit

func main() {
    let client = RpcClient(at: "http://testrpc.cadmean.ru")
    
    client.function(of: "sum").call(with: Argument(of: 1), Argument(of: 2)) { (res: Int?, err) in
        print("result: \(res), error: \(err)")
    }
}
```

## Contributing

### Error handling

### Authorization

Feel free to submit issues or create pull requests following fork-and-pull git workflow.

## See also

* [C# client and server library](https://github.com/cadmean-ru/csharpRPCKit)
* [Android client library](https://github.com/cadmean-ru/androidRPCKit)
* [Python client library](https://github.com/cadmean-ru/pythonRPCKit)
* [Example server](https://github.com/cadmean-ru/ExampleRpcServer)
