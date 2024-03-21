//
//  LoginViewController.swift
//  RelayMessenger
//
//  Created by JJ on 13/03/24.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    //MARK: - Properties
    var viewModel = LoginViewModel()
    private let welcomeLabel: UILabel = CustomLabel(text: "RelayMessenger💬", textFont: .boldSystemFont(ofSize: 24), labelColor: UIColor(red: 0, green: 0.0745, blue: 0.5176, alpha: 1))
    
    private let profileImageView: UIImageView = CustomImageView(image: #imageLiteral(resourceName: "profile"), width: 50,height: 50)
    
    
    private let emailTextField = CustomTextField(placeholder: "Email", keyboardType: .emailAddress)
    private let passwordTextField = CustomTextField(placeholder: "Password", isSecureText: true)
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.primaryButton(buttonText: "Login")
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
    
    private let continueLabel: UILabel = CustomLabel(text: "or continue with Google" ,labelColor: .lightGray)
    
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
        guard let email = emailTextField.text?.lowercased() else {return}
        guard let password = passwordTextField.text else {return}
        showLoader(true)
        AuthServices.loginUser(withEmail: email, withPassword: password) { result, error in
            self.showLoader(false)
            if let error = error{
                self.showMessage(title: "Error:", message: error.localizedDescription)
                return
            }
            self.showLoader(false)
            print("Succesful login...")
            
            self.navToConversationVC()
        }
    }
    @objc func handleForgetPassword(){
        print("reset password link sent!")
    }
    @objc func handleSignUpButton(){
        let controller = RegisterViewController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    @objc func handleGoogleSignIn(){
        showLoader(true)
        setupGoogle()
    }
    @objc func handleTextChanged(sender: UITextField){
        sender == emailTextField ? (viewModel.email = sender.text) : (viewModel.password = sender.text)
        updateForm()
    }
    
    private func updateForm(){
        loginButton.isEnabled = viewModel.formIsValid
        loginButton.backgroundColor = viewModel.backgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        
    }
    
    func navToConversationVC(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        showLoader(true)
        UserServices.fetchUser(uid: uid) { user in
            self.showLoader(false)
            let controller = ConversationViewController(user: user)
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
        
    }
}


//MARK: - Register Delegate

extension LoginViewController: RegisterVC_Delegate{
    func didSuccesfullyCreateAccount(_ vc: RegisterViewController) {
        vc.navigationController?.popViewController(animated: true)
        navToConversationVC()
    }
    
    
}
