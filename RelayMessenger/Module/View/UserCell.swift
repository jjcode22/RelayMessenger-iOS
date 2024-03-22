//
//  UserCell.swift
//  RelayMessenger
//
//  Created by JJ on 21/03/24.
//

import UIKit

class UserCell: UITableViewCell {
    //MARK: - properties
    private var profileImageView = CustomImageView(image: #imageLiteral(resourceName: "Google_Contacts_logo copy"), width: 48, backgroundColor: .lightGray, height: 48, cornerRadius: 24)
    private var fullname = CustomLabel(text: "fullname", labelColor: .lightGray)
    private var username = CustomLabel(text: "username",textFont: .boldSystemFont(ofSize: 16))
    
    
    //MARK: - lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        addSubview(profileImageView)
        profileImageView.centerY(inView: self,leftAnchor: leftAnchor)
        
        let stackView = UIStackView(arrangedSubviews: [username,fullname])
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
