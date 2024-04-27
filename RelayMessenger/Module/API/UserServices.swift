//
//  UserServices.swift
//  RelayMessenger
//
//  Created by JJ on 21/03/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

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
    
    static func fetchUsers(completion: @escaping([User]) -> Void){
        Collection_User.getDocuments { snapshot, error in
            guard let snapshot = snapshot else {return}
            if let error = error{
                print("Error fetching users: \(error)")
            }
            let users = snapshot.documents.map({User(dictionary: $0.data())})
            completion(users)
        
        }
    }
    
    static func updateUserData(data: [String: Any],completion: @escaping(Error?) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        Collection_User.document(uid).updateData(data, completion: completion)
        
    }
}
