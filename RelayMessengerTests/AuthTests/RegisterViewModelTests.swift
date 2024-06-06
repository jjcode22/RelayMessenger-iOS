//
//  RegisterViewModelTests.swift
//  RelayMessengerTests
//
//  Created by JJ on 06/06/24.
//

import XCTest
@testable import RelayMessenger

class RegisterViewModelTests: XCTestCase {

    var viewModel: RegisterViewModel!

    override func setUp() {
        super.setUp()
        viewModel = RegisterViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testValidCredentials() {
        viewModel.email = "emrata@gmail.com"
        viewModel.password = "emrat12"
        viewModel.fullname = "Emily Ratajkowski"
        viewModel.username = "emrata"
        
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
    
    func testInvalidEmailFormat() {
        viewModel.email = "invalid_email"
        viewModel.password = "emrat12"
        
        XCTAssertFalse(viewModel.formIsValid)
    }

    func testInvalidPassword() {
        viewModel.email = "emrata@gmail.com"
        viewModel.password = "pass" // Password less than minimum length
        
        XCTAssertFalse(viewModel.formIsValid)
    }

}



