//
//  LoginViewModelTests.swift
//  RelayMessengerTests
//
//  Created by JJ on 06/06/24.
//

import XCTest
@testable import RelayMessenger

class LoginViewModelTests: XCTestCase {

    var viewModel: LoginViewModel!

    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testValidCredentials() {
        viewModel.email = "emrata@gmail.com"
        viewModel.password = "emrat12"
        
        XCTAssertTrue(viewModel.formIsValid)
    }

    func testEmptyEmail() {
        viewModel.email = ""
        viewModel.password = "emrat12"
        
        XCTAssertFalse(viewModel.formIsValid)
    }

    func testEmptyPassword() {
        viewModel.email = "emrata@gmail.com"
        viewModel.password = ""
        
        XCTAssertFalse(viewModel.formIsValid)
    }

}
