import Foundation

public protocol HttpPostClient {
    func post(url: URL, data: Data?)
}
