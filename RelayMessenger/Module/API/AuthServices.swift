//
//  AuthServices.swift
//  RelayMessenger
//
//  Created by JJ on 14/03/24.
//

import Foundation
import UIKit
import FirebaseFirestore

struct AuthCredential {
    let email: String
    let password: String
    let username: String
    let fullname: String
    let image: UIImage
}

struct AuthServices {
    static func loginUser(){
        
    }
    
    static func registerUser(credential: AuthCredential){
        Collection_User
        
    }
    
}
