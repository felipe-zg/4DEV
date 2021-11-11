import Foundation
import Domain

public class RemoteAddAccount {
    var url: URL
    var httpPostClient: HttpPostClient
    
    public init(url: URL, httpPostClient: HttpPostClient) {
        self.url = url
        self.httpPostClient = httpPostClient
    }
    
    public func add(model addAccoundModel: AddAccountModel) {
        httpPostClient.post(url: url, data: addAccoundModel.toData())
    }
}
