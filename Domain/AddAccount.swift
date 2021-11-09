import Foundation

protocol AddAccount {
    func add(model addAccoundModel: AddAccountModel, completion: (Result<AccountModel, Error>))
}

struct AddAccountModel {
    var name: String
    var email: String
    var password: String
    var passwordConfirmation: String
}


