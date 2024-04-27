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
    
    private let unReadMsgLabel: UILabel = {
        let label = UILabel()
        label.text = "7"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        label.backgroundColor = .systemBlue
        label.textAlignment = .center
        label.setDimensions(height: 28, width: 28)
        label.layer.cornerRadius = 14
        label.clipsToBounds = true
        return label
    }()
    
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
        profileImageView.contentMode = .scaleAspectFill
        
        let stackView = UIStackView(arrangedSubviews: [fullname,recentMessage])
        
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        
        addSubview(stackView)
        stackView.centerY(inView: profileImageView,leftAnchor: profileImageView.rightAnchor, paddingLeft: 15)
        
        let stackDate = UIStackView(arrangedSubviews: [dateLabel,unReadMsgLabel])
        stackDate.axis = .vertical
        stackDate.spacing = 8
        stackDate.alignment = .trailing
        
        addSubview(stackDate)
        stackDate.centerY(inView: profileImageView,rightAnchor: rightAnchor,paddingRight: 8)

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
        self.unReadMsgLabel.text = "\(viewModel.unReadCount)"
        self.unReadMsgLabel.isHidden = viewModel.shouldHideUnReadLabel
        
    }
}
