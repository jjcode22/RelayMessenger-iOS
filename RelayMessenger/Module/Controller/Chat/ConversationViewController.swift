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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ConversationCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
