//
//  ChatViewController.swift
//  RelayMessenger
//
//  Created by JJ on 22/03/24.
//
import Foundation
import UIKit

class ChatViewController: UICollectionViewController {
    //MARK: - properties
    private let reuseIdentifier = "ChatCell"
    private let chatHeaderIdentifer = "ChatHeader"
    private var messages = [[Message]]()
    
    private lazy var customInputView: CustomInputView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let iv = CustomInputView(frame: frame)
        iv.delegate = self
        return iv
    }()
    
    lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        return picker
    }()
    
    private lazy var attachAlert: UIAlertController = {
        let alert = UIAlertController(title: "Attach file", message: "Select the button you want to attach from", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.handleCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.handleGallery()
        }))
        
        alert.addAction(UIAlertAction(title: "Location", style: .default, handler: { _ in
            print("Location")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        
        return alert
        
    }()
    
    var currentUser: User
    var otherUser: User
    
    //MARK: - lifecycle
    init(currentUser: User,otherUser: User) {
        self.currentUser = currentUser
        self.otherUser = otherUser
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(ChatHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: chatHeaderIdentifer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchMessages()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.markAllMessagesAsRead()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        markAllMessagesAsRead()
    }
    
    override var inputAccessoryView: UIView?{
        get {return customInputView}
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    //MARK: - helpers
    private func configureUI(){
        collectionView.backgroundColor = .white
        title = otherUser.fullname
        
        collectionView.register(ChatCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .onDrag
        
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
    }
    
    private func fetchMessages(){
        MessageServices.fetchMessages(otherUser: otherUser) { messages in
            //This dictionary method groups messages values by the keys returned in the closure - in our case it groups messages by the date timestamp of the messages in the dictionary where keys are the dates and values are arrays of messages with that date
            let groupedMessages = Dictionary(grouping: messages) { (element) -> String in
                let dateValue = element.timestamp.dateValue()
                let stringDateValue = self.stringValue(forDate: dateValue)
                return stringDateValue ?? ""
            }
            //remove all messages from dict to avoid duplicate messages in the chat
            self.messages.removeAll()
            
            //Sort the keys i.e date timestamps of the message dict in descending order
            let sortedKeys = groupedMessages.keys.sorted(by: {$0 < $1})
            sortedKeys.forEach { key in
                let values = groupedMessages[key]
                self.messages.append(values ?? [])
            }
            
            self.collectionView.reloadData()
            self.collectionView.scrollToLastItem()
        }
    }
    
    private func markAllMessagesAsRead(){
        MessageServices.markAllMessagesAsRead(otherUser: otherUser)
        
    }
    
}

extension ChatViewController{
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            guard let firstMessage = messages[indexPath.section].first else {return UICollectionReusableView()}
            
            let dateValue = firstMessage.timestamp.dateValue()
            let stringValue = stringValue(forDate: dateValue)
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: chatHeaderIdentifer, for: indexPath) as! ChatHeader
            cell.dateValue = stringValue
            return cell
        }
        return UICollectionReusableView()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChatCell
        let message = messages[indexPath.section][indexPath.row]
        cell.viewModel = MessageViewModel(message: message)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
}

//MARK: - Delegate FlowLayout
extension ChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 15, left: 0, bottom: 15, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let cell = ChatCell(frame: frame)
        let message = messages[indexPath.section][indexPath.row]
        cell.viewModel = MessageViewModel(message: message)
        cell.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = cell.systemLayoutSizeFitting(targetSize)
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
    
}

//MARK: - CustomInputViewDelegate
extension ChatViewController: CustomInputViewDelegate {
    func inputViewForAudio(_ view: CustomInputView, audioURL: URL) {
        //
        self.showLoader(true)
        FileUploader.uploadAudio(audioURL: audioURL) { audioString in
            MessageServices.fetchSingleRecentMessage(otherUser: self.otherUser) { unReadCount in
                MessageServices.uploadMessage(audioURL: audioString,currentUser: self.currentUser, otherUser: self.otherUser, unReadCount: unReadCount + 1) { error in
                    self.showLoader(false)
                    if let error = error {
                        print("\(error.localizedDescription)")
                        return
                    }
                }
            }
        }
    }
    
    func inputViewForAttach(_ view: CustomInputView) {
        present(attachAlert, animated: true)
    }
    
    func inputView(_ view: CustomInputView, wantToUploadMessage message: String) {
        MessageServices.fetchSingleRecentMessage(otherUser: otherUser) { [self] unReadCount in
            //increment unReadCount by 1 every time a new message is uploaded in the chat
            MessageServices.uploadMessage(message: message, currentUser: currentUser, otherUser: otherUser, unReadCount: unReadCount + 1) { _ in
                print("message sent")
                self.collectionView.reloadData()
            }
        }
        view.clearTextView()

    }
    
    
}
