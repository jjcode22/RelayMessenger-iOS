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
    let imageURL: String
    let videoURL: String
    let audioURL: String
    let locationURL: String
    
    var isFromCurrentUser: Bool
    
    var chatPartnerID: String {
        return isFromCurrentUser ? toID : fromID
    }
    
    let newMsgCount: Int
    
    init(dictionary: [String: Any]){
        self.text = dictionary["text"] as? String ?? ""
        self.toID = dictionary["toID"] as? String ?? ""
        self.fromID = dictionary["fromID"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.profileImage = dictionary["profileImage"] as? String ?? ""
        self.newMsgCount = dictionary["newMsgCount"] as? Int ?? 0
        self.imageURL = dictionary["imageURL"] as? String ?? ""
        self.videoURL = dictionary["videoURL"] as? String ?? ""
        self.audioURL = dictionary["audioURL"] as? String ?? ""
        self.locationURL = dictionary["locationURL"] as? String ?? ""
        
        self.isFromCurrentUser = fromID == Auth.auth().currentUser?.uid
    }
    
}
