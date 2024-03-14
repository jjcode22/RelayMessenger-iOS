//
//  LoginViewController.swift
//  RelayMessenger
//
//  Created by JJ on 13/03/24.
//

import Foundation
import UIKit


class LoginViewController: UIViewController {
    //MARK: - Properties
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "RelayMessenger💬"
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = #colorLiteral(red: 0.0824, green: 0, blue: 0.2784, alpha: 1)
        label.tintColor = .black
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "profile")
        iv.contentMode = .scaleAspectFit
        iv.setDimensions(height: 50, width: 50)
        return iv
    }()
    
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    
    
    
    //MARK: - Helpers
    private func configureUI(){
        view.backgroundColor = #colorLiteral(red: 0.9686, green: 0.9686, blue: 0.9686, alpha: 1)
        view.addSubview(welcomeLabel)
        welcomeLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        welcomeLabel.centerX(inView: view)
        
        view.addSubview(profileImageView)
        profileImageView.anchor(top: welcomeLabel .bottomAnchor, paddingTop: 20)
        profileImageView.centerX(inView: view)
    }
}
