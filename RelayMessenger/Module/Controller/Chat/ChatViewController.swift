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
    private var messages:[Message] = []
    
    private lazy var customInputView: CustomInputView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let iv = CustomInputView(frame: frame)
        iv.delegate = self
        return iv
    }()
    
    private var currentUser: User
    private var otherUser: User
    
    //MARK: - lifecycle
    init(currentUser: User,otherUser: User) {
        self.currentUser = currentUser
        self.otherUser = otherUser
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
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
    }
    
    private func fetchMessages(){
        MessageServices.fetchMessages(otherUser: otherUser) { messages in
            self.messages = messages
            print(messages)
            self.collectionView.reloadData()
        }
    }
    
    private func markAllMessagesAsRead(){
        MessageServices.markAllMessagesAsRead(otherUser: otherUser)
        
    }
}

extension ChatViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChatCell
        let message = messages[indexPath.row]
        cell.viewModel = MessageViewModel(message: message)
        return cell
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
        let message = messages[indexPath.row]
        cell.viewModel = MessageViewModel(message: message)
        cell.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = cell.systemLayoutSizeFitting(targetSize)
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
    
}

//MARK: - CustomInputViewDelegate
extension ChatViewController: CustomInputViewDelegate {
    func inputView(_ view: CustomInputView, wantToUploadMessage message: String) {
        MessageServices.fetchSingleRecentMessage(otherUser: otherUser) { [self] unReadCount in
            //increment unReadCount by 1 every time a new message is uploaded in the chat
            MessageServices.uploadMessage(message: message, currentUser: currentUser, otherUser: otherUser, unReadCount: unReadCount + 1) { _ in
                print("message sent")
                collectionView.reloadData()
            }
        }
        view.clearTextView()

    }
    
    
}
