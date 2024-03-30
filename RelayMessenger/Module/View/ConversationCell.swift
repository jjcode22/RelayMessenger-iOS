//
//  ConversationCell.swift
//  RelayMessenger
//
//  Created by JJ on 21/03/24.
//

import UIKit

class ConversationCell: UITableViewCell {
    //MARK: - Properties
    var viewModel: MessageViewModel?{
        didSet{
            configure()
        }
    }
    
    private let profileImageView = CustomImageView(image: #imageLiteral(resourceName: "Google_Contacts_logo copy"),width: 60,backgroundColor: .lightGray, height: 60, cornerRadius: 30)
    
    
    private let fullname = CustomLabel(text: "Fullname")
    private let recentMessage = CustomLabel(text: "Resent message",labelColor: .lightGray)
    private let dateLabel = CustomLabel(text: "04/06/2024",labelColor: .lightGray)
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor)
        
        let stackView = UIStackView(arrangedSubviews: [fullname,recentMessage])
        
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        
        addSubview(stackView)
        stackView.centerY(inView: profileImageView,leftAnchor: profileImageView.rightAnchor, paddingLeft: 15)
        
        addSubview(dateLabel)
        dateLabel.centerY(inView: self,rightAnchor: rightAnchor, paddingRight: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configure(){
        guard let viewModel = viewModel else {return}
        
        self.profileImageView.sd_setImage(with: viewModel.profileImageURL)
        self.fullname.text = viewModel.fullname
        self.dateLabel.text = viewModel.timestamp
        self.recentMessage.text = viewModel.messageText
        
    }
}
