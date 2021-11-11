import XCTest
import Domain

class RemoteAddAccount {
    var url: URL
    var httpPostClient: HttpPostClient
    
    init(url: URL, httpPostClient: HttpPostClient) {
        self.url = url
        self.httpPostClient = httpPostClient
    }
    
    func add(model addAccoundModel: AddAccountModel) {
        httpPostClient.post(url: url, data: addAccoundModel.toData())
    }
}

protocol HttpPostClient {
    func post(url: URL, data: Data?)
}

class RemoteAddAccountTests: XCTestCase {

    func test_add_should_call_httpPostClient_with_correct_url() {
        let url = URL(string: "https://anuurl.com")!
        let addAccountModel = makeAddAccountModel()
        let (sut, httpPostClientSpy) = makeSut(url: url)
        sut.add(model: addAccountModel)
        XCTAssertEqual(httpPostClientSpy.url, url)
    }
    
    func test_add_should_call_httpPostClient_with_correct_data() {
        let addAccountModel = makeAddAccountModel()
        let (sut, httpPostClientSpy) = makeSut()
        sut.add(model: addAccountModel)
        XCTAssertEqual(httpPostClientSpy.data, addAccountModel.toData())
    }
}

extension RemoteAddAccountTests {
    func makeSut(url: URL = URL(string: "https://anuurl.com")!) -> (sut: RemoteAddAccount, httpPostClientSpu: HttpPostClientSpy) {
        let httpPostClientSpy = HttpPostClientSpy()
        let sut = RemoteAddAccount(url: url, httpPostClient: httpPostClientSpy)
        return (sut, httpPostClientSpy)
    }
    
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "fakeName", email: "fakeemail@email.com", password: "fakepassword", passwordConfirmation: "fakepassword")
    }
    
    class HttpPostClientSpy: HttpPostClient {
        var url: URL?
        var data: Data?
        
        func post(url: URL, data: Data?) {
            self.url = url
            self.data = data
        }
    }
}
