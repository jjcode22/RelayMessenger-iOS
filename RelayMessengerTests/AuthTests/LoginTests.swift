//
//  LoginTests.swift
//  RelayMessengerTests
//
//  Created by JJ on 06/06/24.
//

import XCTest

@testable import RelayMessenger


class LoginTests: XCTestCase{
    var viewModel: LoginViewModel!
    
    override func setUpWithError() throws{
        viewModel = LoginViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testLoginSuccess(){
        AuthServices.loginUser(withEmail: "emrata@gmail.com", withPassword: "emrat12") { result, error in
            XCTAssertNotNil(result)
            XCTAssertNil(error)
        }
    }
    
    func testLoginFailure(){
        AuthServices.loginUser(withEmail: "emraasdl21313@gmail.com", withPassword: "dshfuq34") { result, error in
            XCTAssertNil(result)
            XCTAssertNotNil(error)
        }
    }
    
}
