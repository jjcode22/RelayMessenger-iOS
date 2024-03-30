//
//  ConversationViewController.swift
//  RelayMessenger
//
//  Created by JJ on 21/03/24.
//

import UIKit
import FirebaseAuth

class ConversationViewController: UIViewController {
    //MARK: - Properties
    private var user: User
    private var tableView = UITableView()
    private let reuseIdentifier = "ConversationCell"
    
    private let unReadMsgLabel: UILabel = {
        let label = UILabel()
        label.text = "7"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.backgroundColor = .systemBlue
        label.textAlignment = .center
        label.setDimensions(height: 40, width: 40)
        label.layer.cornerRadius = 20
        label.clipsToBounds = true
        return label
    }()
    
    private var conversations: [Message] = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    private var conversationDictionary = [String: Message]()
    
    
    //MARK: - Lifecycle
    init(user: User){
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        configureUI()
        configureTableView()
        fetchConversations()
    }
    
    //MARK: - Helpers
    
    private func configureUI(){
        view.backgroundColor = .white
        title = user.fullname
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        let newChatButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(handleNewChat))
        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.rightBarButtonItem = newChatButton
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingLeft: 15,paddingRight: 15 )
        
        view.addSubview(unReadMsgLabel)
        unReadMsgLabel.anchor(left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingLeft: 20, paddingBottom: 10)
    }
    
    private func fetchConversations(){
        MessageServices.fetchRecentMessages { conversations in
            conversations.forEach { conversation in
                self.conversationDictionary[conversation.chatPartnerID] = conversation
            }
            self.conversations = Array(self.conversationDictionary.values)
        }
        
    }
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.register(ConversationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView() //Empty space to add nothing
    }
    
    @objc func handleLogout(){
        do{
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        }catch{
            print("Error signing out: \(error)")
        }
        
    }
    
    @objc func handleNewChat(){
        let controller = NewChatViewController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        present(nav, animated: true, completion: nil)
        
    }
    
    private func openChat(currentUser: User,otherUser: User){
        let controller = ChatViewController(currentUser: currentUser, otherUser: otherUser)
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - TableView

extension ConversationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ConversationCell
        let conversation = conversations[indexPath.row]
        cell.viewModel = MessageViewModel(message: conversation)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conversation = conversations[indexPath.row]
        showLoader(true)
        UserServices.fetchUser(uid: conversation.chatPartnerID) { [self] otherUser in
            showLoader(false)
            openChat(currentUser: user, otherUser: otherUser)
        }
        
    }
    
}

//MARK: - NewChatViewController delegate

extension ConversationViewController: NewChatViewControllerDelegate{
    func controller(_ vc: NewChatViewController, wantToChatWithUser otherUser: User) {
        vc.dismiss(animated: true, completion: nil)
        print(otherUser.fullname)
        openChat(currentUser: user, otherUser: otherUser)
    }
    
    
}
