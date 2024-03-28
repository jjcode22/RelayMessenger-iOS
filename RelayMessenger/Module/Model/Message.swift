//
//  Message.swift
//  RelayMessenger
//
//  Created by JJ on 28/03/24.
//

import Foundation
import FirebaseFirestoreInternal
import FirebaseAuth

struct Message {
    let text: String
    let fromID: String
    let toID: String
    let timestamp: Timestamp
    let username: String
    let fullname: String
    let profileImage: String
    
    var isFromCurrentUser: Bool
    
    init(dictionary: [String: Any]){
        self.text = dictionary["text"] as? String ?? ""
        self.toID = dictionary["toID"] as? String ?? ""
        self.fromID = dictionary["fromID"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.profileImage = dictionary["profileImage"] as? String ?? ""
        
        self.isFromCurrentUser = fromID == Auth.auth().currentUser?.uid
    }
    
}
