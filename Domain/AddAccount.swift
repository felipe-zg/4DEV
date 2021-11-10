import Foundation

public protocol AddAccount {
    func add(model addAccoundModel: AddAccountModel, completion: (Result<AccountModel, Error>))
}

public struct AddAccountModel {
    public var name: String
    public var email: String
    public var password: String
    public var passwordConfirmation: String
}


