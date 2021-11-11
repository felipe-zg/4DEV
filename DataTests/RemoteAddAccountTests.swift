//
//  DataTests.swift
//  DataTests
//
//  Created by Felipe Zêba on 11/9/21.
//

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
        let data = try? JSONEncoder().encode(addAccoundModel)
        httpPostClient.post(url: url, data: data)
    }
}

protocol HttpPostClient {
    func post(url: URL, data: Data?)
}

class RemoteAddAccountTests: XCTestCase {

    func test_add_should_call_httpPostClient_with_correct_url() {
        let url = URL(string: "https://anuurl.com")!
        let httpPostClientSpy = HttpPostClientSpy()
        let addAccountModel = makeAddAccountModel()
        let sut = RemoteAddAccount(url: url, httpPostClient: httpPostClientSpy)
        sut.add(model: addAccountModel)
        XCTAssertEqual(httpPostClientSpy.url, url)
    }
    
    func test_add_should_call_httpPostClient_with_correct_data() {
        let httpPostClientSpy = HttpPostClientSpy()
        let addAccountModel = makeAddAccountModel()
        let sut = RemoteAddAccount(url: URL(string: "https://anuurl.com")!, httpPostClient: httpPostClientSpy)
        sut.add(model: addAccountModel)
        let data = try? JSONEncoder().encode(addAccountModel)
        XCTAssertEqual(httpPostClientSpy.data, data)
    }
}

extension RemoteAddAccountTests {
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
