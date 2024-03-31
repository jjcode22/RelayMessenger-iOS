//
//  CustomInputView.swift
//  RelayMessenger
//
//  Created by JJ on 22/03/24.
//

import Foundation
import UIKit

protocol CustomInputViewDelegate: AnyObject {
    func inputView(_ view: CustomInputView, wantToUploadMessage message: String)
    func inputViewForAttach(_ view: CustomInputView)
    
}


class CustomInputView: UIView{
    //MARK: - properties
    let inputTextView = InputTextView()
    weak var delegate: CustomInputViewDelegate?
    
    private let postBackgroundColor: CustomImageView = {
        let tap = UITapGestureRecognizer(target: CustomInputView.self, action: #selector(handlePostButton))
        let iv = CustomImageView(width: 40, backgroundColor: #colorLiteral(red: 0, green: 0.0745, blue: 0.5176, alpha: 1), height: 40, cornerRadius: 20)
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tap)
        iv.isHidden = true
        return iv
    }()
    
    private lazy var postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handlePostButton), for: .touchUpInside)
        button.setDimensions(height: 28, width: 28)
        button.isHidden = true
        return button
    }()
    
    private lazy var attachButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "paperclip.circle"), for: .normal)
        button.setDimensions(height: 40, width: 40)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(handleAttach), for: .touchUpInside)
        return button
    }()
    
    private lazy var recordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "mic.circle"), for: .normal)
        button.setDimensions(height: 40, width: 40)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(handleRecord), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [inputTextView,postBackgroundColor,attachButton,recordButton])
        sv.axis = .horizontal
        sv.spacing = 8
        sv.alignment = .center
        sv.distribution = .fillProportionally
        return sv
    }()
    
    
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        autoresizingMask = .flexibleHeight
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor,left: leftAnchor,right: rightAnchor,paddingLeft: 5,paddingRight: 5)
        addSubview(postButton)
        postButton.center(inView: postBackgroundColor)
        
        
        inputTextView.anchor(top: topAnchor,left: leftAnchor,bottom: safeAreaLayoutGuide.bottomAnchor, right: postBackgroundColor.leftAnchor, paddingTop: 12, paddingLeft: 8,paddingBottom: 5,paddingRight: 8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .lightGray
        addSubview(dividerView)
        dividerView.anchor(top: topAnchor,left: leftAnchor,right: rightAnchor, height: 0.5)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: InputTextView.textDidChangeNotification, object: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize{
        return .zero
    }
    
    
    
    //MARK: - helpers
    
    @objc func handlePostButton(){
        delegate?.inputView(self, wantToUploadMessage: inputTextView.text)
    }
    
    @objc func handleAttach(){
        delegate?.inputViewForAttach(self)
        
    }
    
    @objc func handleRecord(){
        
    }
    
    @objc func handleTextDidChange(){
        let isTextEmpty = inputTextView.text.isEmpty || inputTextView.text == ""
        postButton.isHidden = isTextEmpty
        postBackgroundColor.isHidden = isTextEmpty
        
        attachButton.isHidden = !isTextEmpty
        recordButton.isHidden = !isTextEmpty
        
    }
    
    func clearTextView(){
        inputTextView.text = ""
        inputTextView.placeholderLabel.isHidden = false
    }
}
