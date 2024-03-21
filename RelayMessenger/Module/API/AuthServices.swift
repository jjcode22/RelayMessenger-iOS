//
//  AuthServices.swift
//  RelayMessenger
//
//  Created by JJ on 14/03/24.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth

struct AuthCredential {
    let email: String
    let password: String
    let username: String
    let fullname: String
    let image: UIImage
}

struct AuthServices {
    
    static func loginUser(withEmail email: String, withPassword password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }

    
    static func registerUser(credential: AuthCredential, completion: @escaping(Error?) -> Void){
        FileUploader.uploadImage(image: credential.image) { imageURL in
            Auth.auth().createUser(withEmail: credential.email, password: credential.password) { result, error in
                if let error = error{
                    print("Error creating account \(error.localizedDescription)")
                    return
                }
                guard let uid = result?.user.uid else {return}
                
                let data: [String: Any] = [
                    "email": credential.email,
                    "username": credential.username,
                    "fullname": credential.fullname,
                    "uid": uid,
                    "profileImageURL": imageURL
                    
                ]
                Collection_User.document(uid).setData(data, completion: completion)
            }
        }
        
    }
    
}
