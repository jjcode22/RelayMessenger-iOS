//
//  SplashViewController.swift
//  RelayMessenger
//
//  Created by JJ on 21/03/24.
//

import UIKit
import FirebaseAuth


class SplashViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser?.uid == nil {
            let controller = LoginViewController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true, completion: nil)
        }else {
            guard let uid = Auth.auth().currentUser?.uid else {return}
            showLoader(true)
            UserServices.fetchUser(uid: uid) {[self] user in
                showLoader(false)
                let controller = ConversationViewController(user: user)
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                present(nav, animated: true, completion: nil)
                
            }
            
        }
    }
    
}
