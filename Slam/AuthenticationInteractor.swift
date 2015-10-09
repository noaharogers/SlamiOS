import Foundation

@objc public protocol AuthenticationInteractor {

    var view: AuthenticationView? { get set }
    func attemptLogin(email email: String, password: String)

}
