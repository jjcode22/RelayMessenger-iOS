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
    func inputViewForAudio(_ view: CustomInputView, audioURL: URL)
    
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
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setDimensions(height: 40, width: 100)
        button.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var sendRecordingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.tintColor = .white
        button.backgroundColor = .red
        button.setDimensions(height: 40, width: 100)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSendRecording), for: .touchUpInside)
        return button
    }()
    
    private let timerLabel = CustomLabel(text: "00:00")
    
    private lazy var recordStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [cancelButton,timerLabel,sendRecordingButton])
        sv.axis = .horizontal
        sv.isHidden = true
        sv.alignment = .center
        return sv
    }()
    
    var duration: CGFloat = 0.0
    var timer: Timer!
    var recorder = AKAudioRecorder.shared
    
    
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
        
        addSubview(recordStackView)
        recordStackView.anchor(top: topAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 15,paddingLeft: 12,paddingRight: 12)
        
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
        stackView.isHidden = true
        recordStackView.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.recorder.myRecordings.removeAll() // Delete all recordings before starting a new record
            self.recorder.record() // We will start recording the voice
            self.setTimer()
        })
        
    }
    
    @objc func handleTextDidChange(){
        let isTextEmpty = inputTextView.text.isEmpty || inputTextView.text == ""
        postButton.isHidden = isTextEmpty
        postBackgroundColor.isHidden = isTextEmpty
        
        attachButton.isHidden = !isTextEmpty
        recordButton.isHidden = !isTextEmpty
        
    }
    
    @objc func handleCancelButton(){
        recordStackView.isHidden = true
        stackView.isHidden = false
        
    }
    
    @objc func handleSendRecording(){
        recorder.stopRecording()
        
        let name = recorder.getRecordings.last ?? ""
        guard let audioURL = recorder.getAudioURL(name: name) else {return}
        
        //Upload the recorded audio file
        self.delegate?.inputViewForAudio(self, audioURL: audioURL)
        
        recordStackView.isHidden = true
        stackView.isHidden = false
        
    }
    
    func clearTextView(){
        inputTextView.text = ""
        inputTextView.placeholderLabel.isHidden = false
    }
    
    func setTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if recorder.isRecording && !recorder.isPlaying{
            duration += 1
            self.timerLabel.text = duration.timeStringFormatter
        }else {
            timer.invalidate()
            duration = 0
            self.timerLabel.text = "00:00"
        }
    }
}
