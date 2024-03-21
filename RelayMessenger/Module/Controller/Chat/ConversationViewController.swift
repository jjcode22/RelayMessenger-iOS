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
    }
    
    //MARK: - Helpers
    
    private func configureUI(){
        view.backgroundColor = .systemMint
        title = user.fullname
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.leftBarButtonItem = logoutButton
        
    }
    
    @objc func handleLogout(){
        do{
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        }catch{
            print("Error signing out: \(error)")
        }
        
    }
}
