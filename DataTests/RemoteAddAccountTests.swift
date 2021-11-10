//
//  DataTests.swift
//  DataTests
//
//  Created by Felipe Zêba on 11/9/21.
//

import XCTest

class RemoteAddAccount {
    var url: URL
    var httpPostClient: HttpPostClient
    
    init(url: URL, httpPostClient: HttpPostClient) {
        self.url = url
        self.httpPostClient = httpPostClient
    }
    
    func add() {
        httpPostClient.post(url: url)
    }
}

protocol HttpPostClient {
    func post(url: URL)
}

class RemoteAddAccountTests: XCTestCase {

    func test_add_should_call_httpPostClient_with_correct_url() {
        let url = URL(string: "https://anuurl.com")!
        let httpPostClientSpy = HttpPostClientSpy()
        let sut = RemoteAddAccount(url: url, httpPostClient: httpPostClientSpy)
        sut.add()
        XCTAssertEqual(httpPostClientSpy.url, url)
    }
}

extension RemoteAddAccountTests {
    class HttpPostClientSpy: HttpPostClient {
        var url: URL?
        
        func post(url: URL) {
            self.url = url
        }
    }
}
