//
//  MessageViewModel.swift
//  RelayMessenger
//
//  Created by JJ on 28/03/24.
//

import Foundation
import UIKit


struct MessageViewModel {
    
    let message: Message
    var messageText: String {
        return message.text
    }
    var messageBackgroundColor: UIColor {
        return message.isFromCurrentUser ? #colorLiteral(red: 0.3913452377, green: 0.4291273579, blue: 1, alpha: 1) : #colorLiteral(red: 0.9245408177, green: 0.9278380275, blue: 0.9309870005, alpha: 1)
    }
    
    var messageColor: UIColor {
        return message.isFromCurrentUser ? #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    var rightAnchorActive: Bool {return message.isFromCurrentUser}
    var leftAnchorActive: Bool {return !message.isFromCurrentUser}
    var shouldHideProfileImage: Bool {
        return message.isFromCurrentUser
    }
    
    var profileImageURL: URL? {
        return URL(string: message.profileImage)
    }
    var timestamp: String? {
        let date = message.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    init(message: Message) {
        self.message = message
    }
}
