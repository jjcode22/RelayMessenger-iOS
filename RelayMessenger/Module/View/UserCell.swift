//
//  UserCell.swift
//  RelayMessenger
//
//  Created by JJ on 21/03/24.
//

import UIKit

class UserCell: UITableViewCell {
    //MARK: - properties
    private var profileImageView = CustomImageView(image: #imageLiteral(resourceName: "Google_Contacts_logo copy"), width: 60, backgroundColor: .lightGray, height: 60, cornerRadius: 30)
    private var fullname = CustomLabel(text: "user's fullname")
    private var username = CustomLabel(text: "username")
    
    
    //MARK: - lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(profileImageView)
        profileImageView.centerY(inView: self,leftAnchor: leftAnchor)
        
        let stackView = UIStackView(arrangedSubviews: [fullname,username])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        
        addSubview(stackView)
        stackView.centerY(inView: profileImageView,leftAnchor: profileImageView.rightAnchor,paddingLeft: 16)
        
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - helpers
}
