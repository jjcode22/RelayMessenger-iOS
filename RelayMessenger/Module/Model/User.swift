//
//  User.swift
//  RelayMessenger
//
//  Created by JJ on 21/03/24.
//

import Foundation


struct User{
    let email: String
    let username: String
    let fullname: String
    let uid: String
    let profileImage: String
    
    init(dictionary: [String: Any]){
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.profileImage = dictionary["profileImageURL"] as? String ?? ""
    }
}
