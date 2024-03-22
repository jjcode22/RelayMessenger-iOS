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
    private var messages:[String] = ["Hey there asdaslkd!!","What are you doing how are u main>>??","hahahahahahha nice very ahslkdasl OKay bro this is kinda cool kd"]
    
    private lazy var customInputView: CustomInputView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let iv = CustomInputView(frame: frame)
        iv.delegate = self
        return iv
    }()
    
    //MARK: - lifecycle
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
        
        collectionView.register(ChatCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

extension ChatViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChatCell
        let text = messages[indexPath.row]
        cell.configure(text: text)
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
        let text = messages[indexPath.row]
        cell.configure(text: text)
        cell.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = cell.systemLayoutSizeFitting(targetSize)
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
    
}

//MARK: - CustomInputViewDelegate
extension ChatViewController: CustomInputViewDelegate {
    func inputView(_ view: CustomInputView, wantToUploadMessage message: String) {
        print(message)
        messages.append(message)
        view.clearTextView()
        collectionView.reloadData()
    }
    
    
}
