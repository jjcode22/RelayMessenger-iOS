//
//  UserServices.swift
//  RelayMessenger
//
//  Created by JJ on 21/03/24.
//

import Foundation
import FirebaseFirestore

struct UserServices{
    static func fetchUser(uid:String, completion: @escaping(User) -> Void ){
        Collection_User.document(uid).getDocument { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let dictionary = snapshot?.data() else {return}
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
}
