//
//  RegisterViewModel.swift
//  RelayMessenger
//
//  Created by JJ on 14/03/24.
//

import Foundation
import UIKit

struct RegisterViewModel: AuthLoginModel {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var formIsValid: Bool {
//        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && password?.isEmpty == false
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && username?.isEmpty == false
    }
    
    var backgroundColor: UIColor{
        return formIsValid ? #colorLiteral(red: 0, green: 0.0745, blue: 0.5176, alpha: 1) : #colorLiteral(red: 0, green: 0.0745, blue: 0.5176, alpha: 1).withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor{
        return formIsValid ? (UIColor.white) : (UIColor(white: 1, alpha: 0.7))
    }
}
