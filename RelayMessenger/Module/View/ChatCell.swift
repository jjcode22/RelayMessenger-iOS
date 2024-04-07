//
//  ChatCell.swift
//  RelayMessenger
//
//  Created by JJ on 22/03/24.
//

import UIKit

protocol ChatCellDelegate: AnyObject {
    func cell(wantsToPlayVideo cell: ChatCell, videoURL: URL?)
    func cell(wantsToShowImage cell:ChatCell, imageURL: URL?)
}

class ChatCell: UICollectionViewCell {
    //MARK: - properties
    weak var delegate: ChatCellDelegate?
    
    var viewModel: MessageViewModel? {
        didSet{
            configure()
        }
    }
    
    private let profileImageView = CustomImageView(width: 30, backgroundColor: .lightGray, height: 30, cornerRadius: 15)
    private let dateLabel = CustomLabel(text: "04/06/2024",textFont: .systemFont(ofSize: 12),labelColor: .lightGray)
    
    private let bubbleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9098039216, blue: 0.9137254902, alpha: 1)
        return view
    }()
    
    var bubbleRightAnchor: NSLayoutConstraint!
    var bubbleLeftAnchor: NSLayoutConstraint!
    var dateRightAnchor: NSLayoutConstraint!
    var dateLeftAnchor: NSLayoutConstraint!
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.backgroundColor = .clear
        tv.isScrollEnabled = false
        tv.text = "Lorem Ipsum Lorem Ipsum Lorem Ipsum "
        tv.font = .systemFont(ofSize: 16)
        return tv
    }()
    
    private lazy var postImage: CustomImageView = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleImage))
        let iv = CustomImageView()
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        iv.isHidden = true
        return iv
    }()
    
    private lazy var postVideo: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        button.tintColor = .white
        button.isHidden = true
        button.setTitle(" Play Video ", for: .normal)
        button.addTarget(self, action: #selector(handlePlayVideoButton), for: .touchUpInside)
        return button
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
        //bubbleContainer Anchor constraints for Leftsided and Rightsided bubbles
        bubbleLeftAnchor = bubbleContainer.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12)
        bubbleLeftAnchor.isActive = false
        bubbleRightAnchor = bubbleContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
        bubbleRightAnchor.isActive = false
        
        bubbleContainer.addSubview(textView)
        textView.anchor(top: bubbleContainer.topAnchor,left: bubbleContainer.leftAnchor,bottom: bubbleContainer.bottomAnchor, right: bubbleContainer.rightAnchor,paddingTop: 4,paddingLeft: 12,paddingBottom: 4,paddingRight: 12)
        
        addSubview(dateLabel)
        //dateLabel Anchor constraints for Leftsided and Rightsided bubbles
        dateLeftAnchor = dateLabel.leftAnchor.constraint(equalTo: bubbleContainer.rightAnchor, constant: 12)
        dateLeftAnchor.isActive = false
        dateRightAnchor = dateLabel.rightAnchor.constraint(equalTo: bubbleContainer.leftAnchor, constant: -12)
        dateRightAnchor.isActive = false
        dateLabel.anchor(bottom: bottomAnchor)
        
        addSubview(postImage)
        postImage.anchor(top: bubbleContainer.topAnchor,left: bubbleContainer.leftAnchor,bottom: bubbleContainer.bottomAnchor, right: bubbleContainer.rightAnchor,paddingTop: 4,paddingLeft: 12,paddingBottom: 4,paddingRight: 12)
        
        addSubview(postVideo)
        postVideo.anchor(top: bubbleContainer.topAnchor,left: bubbleContainer.leftAnchor,bottom: bubbleContainer.bottomAnchor, right: bubbleContainer.rightAnchor,paddingTop: 4,paddingLeft: 12,paddingBottom: 4,paddingRight: 12)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - helpers
    func configure(){
        guard let viewModel = viewModel else {return}
        bubbleContainer.backgroundColor = viewModel.messageBackgroundColor
        textView.text = viewModel.messageText
        textView.textColor = viewModel.messageColor
        
        bubbleRightAnchor.isActive = viewModel.rightAnchorActive
        dateRightAnchor.isActive = viewModel.rightAnchorActive
        
        bubbleLeftAnchor.isActive = viewModel.leftAnchorActive
        dateLeftAnchor.isActive = viewModel.leftAnchorActive
        
        profileImageView.sd_setImage(with: viewModel.profileImageURL)
        profileImageView.isHidden = viewModel.shouldHideProfileImage
        
        guard let timestampString = viewModel.timestamp else {return}
        
        dateLabel.text = timestampString
        
        postImage.sd_setImage(with: viewModel.imageURL)
        textView.isHidden = viewModel.isTextHidden
        postImage.isHidden = viewModel.isImageHidden
        postVideo.isHidden = viewModel.isVideoHidden
        
        if !viewModel.isImageHidden {
            postImage.setHeight(200)
        }
        
    }
    
    @objc func handlePlayVideoButton(){
        guard let viewModel = viewModel else {return}
        delegate?.cell(wantsToPlayVideo: self, videoURL: viewModel.videoURL)
        
    }
    
    @objc func handleImage(){
        guard let viewModel = viewModel else {return}
        delegate?.cell(wantsToShowImage: self, imageURL: viewModel.imageURL)
        
    }
}
