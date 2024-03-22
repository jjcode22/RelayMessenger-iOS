//
//  ChatCell.swift
//  RelayMessenger
//
//  Created by JJ on 22/03/24.
//

import Foundation
import UIKit

class ChatCell: UICollectionViewCell {
    //MARK: - properties
    private let profileImageView = CustomImageView(width: 30, backgroundColor: .lightGray, height: 30, cornerRadius: 15)
    private let dateLabel = CustomLabel(text: "04/06/2024")
    
    private let bubbleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9098039216, blue: 0.9137254902, alpha: 1)
        return view
    }()
    
    var bubbleRightAnchor: NSLayoutConstraint!
    var bubbleLeftAnchor: NSLayoutConstraint!
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.backgroundColor = .clear
        tv.isScrollEnabled = false
        tv.font = .systemFont(ofSize: 16)
        return tv
    }()
    
    
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor,bottom: bottomAnchor,paddingLeft: 10)
        
        addSubview(bubbleContainer)
        bubbleContainer.layer.cornerRadius = 12
        bubbleContainer.anchor(top: topAnchor,bottom: bottomAnchor)
        //set max chat bubble width to 250
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - helpers
}
