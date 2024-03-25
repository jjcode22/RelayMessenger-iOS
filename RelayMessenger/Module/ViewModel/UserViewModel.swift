//
//  UserViewModel.swift
//  RelayMessenger
//
//  Created by JJ on 23/03/24.
//

import Foundation

struct UserViewModel {
    let user: User
    
    var fullname: String {return user.fullname}
    var username: String {return user.username}
    
    var profileImageURL: URL? {return URL(string: user.profileImage)}
    
    init(user: User) {
        self.user = user
    }
}
