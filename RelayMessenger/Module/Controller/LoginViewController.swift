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
    var viewModel = LoginViewModel()
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "RelayMessenger💬"
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = #colorLiteral(red: 0, green: 0.0745, blue: 0.5176, alpha: 1)
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
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.setHeight(50)
        tf.tintColor = .black
        tf.placeholder = "Email"
        tf.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tf.keyboardType = .emailAddress
        tf.layer.cornerRadius = 5
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.setHeight(50)
        tf.tintColor = .black
        tf.placeholder = "Password"
        tf.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tf.isSecureTextEntry = true
        tf.layer.cornerRadius = 5
        return tf
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setHeight(50)
        button.layer.cornerRadius = 10
        button.backgroundColor = #colorLiteral(red: 0, green: 0.0745, blue: 0.5176, alpha: 1).withAlphaComponent(0.5)
        button.isEnabled = false
        button.tintColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleLoginVC), for: .touchUpInside)
        return button
    }()
    
    private lazy var forgetPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setHeight(50)
        button.attributedText(firstString: "Forgot your password?", secondString: "Get help signing in")
        button.addTarget(self, action: #selector(handleForgetPassword), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedText(firstString: "Don't have an account?,", secondString: "Sign up")
        button.setHeight(50)
        button.addTarget(self, action: #selector(handleSignUpButton), for: .touchUpInside)
        return button
    }()
    
    private let continueLabel: UILabel = {
        let label = UILabel()
        label.text = "or continue with Google"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var googleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Google", for: .normal)
        button.setDimensions(height: 50, width: 150)
        button.layer.cornerRadius = 20
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.tintColor = .black
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleGoogleSignIn), for: .touchUpInside)
        return button
    }()
    
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureForTextField()
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
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,loginButton,forgetPasswordButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        
        view.addSubview(stackView)
        stackView.anchor(top: profileImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 30,paddingRight: 30)
        
        view.addSubview(signUpButton)
        signUpButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        signUpButton.centerX(inView: view)
        
        view.addSubview(continueLabel)
        continueLabel.centerX(inView: view, topAnchor: forgetPasswordButton.bottomAnchor, paddingTop: 30)
        
        view.addSubview(googleButton)
        googleButton.centerX(inView: view, topAnchor: continueLabel.bottomAnchor, paddingTop: 12)
        
    }
    
    private func configureForTextField(){
        emailTextField.addTarget(self, action: #selector(handleTextChanged(sender:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextChanged(sender:)), for: .editingChanged)
    }
    
    @objc func handleLoginVC(){
        print("Login succesful!")
    }
    @objc func handleForgetPassword(){
        print("reset password link sent!")
    }
    @objc func handleSignUpButton(){
        print("Registering!")
    }
    @objc func handleGoogleSignIn(){
        print("Google sign in!")
    }
    @objc func handleTextChanged(sender: UITextField){
        sender == emailTextField ? (viewModel.email = sender.text) : (viewModel.password = sender.text)
        updateForm()
    }
    
    private func updateForm(){
        loginButton.isEnabled = viewModel.formIsValid
        loginButton.backgroundColor = viewModel.backgroudColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        
    }
}
