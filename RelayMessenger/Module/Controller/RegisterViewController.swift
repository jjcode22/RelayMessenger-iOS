//
//  RegisterViewController.swift
//  RelayMessenger
//
//  Created by JJ on 13/03/24.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    //MARK: - Properties
    var viewModel = RegisterViewModel()
    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = UIButton()
        button.setHeight(50)
        button.attributedText(firstString: "Already have an account?", secondString: "Sign In")
        button.addTarget(self, action: #selector(handleAlreadyHaveAccountButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus_photo")!, for: .normal)
        button.setDimensions(height: 140, width: 140)
        button.addTarget(self, action: #selector(handleAddPhotoButton), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email", keyboardType: .emailAddress)
    private let passwordTextField = CustomTextField(placeholder: "Password", isSecureText: true)
    private let fullNameTextField = CustomTextField(placeholder: "Full name")
    private let usernameTextField = CustomTextField(placeholder: "Username")
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setHeight(50)
        button.layer.cornerRadius = 10
        button.backgroundColor = #colorLiteral(red: 0, green: 0.0745, blue: 0.5176, alpha: 1).withAlphaComponent(0.5)
        button.isEnabled = false
        button.tintColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
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
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        alreadyHaveAccountButton.centerX(inView: view)
        
        view.addSubview(addPhotoButton)
        addPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 30)
        
        let stackView = UIStackView(arrangedSubviews: [usernameTextField,fullNameTextField,emailTextField,passwordTextField,signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        
        view.addSubview(stackView)
        stackView.anchor(top: addPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 30,paddingRight: 30)
    
    }
    
    private func configureForTextField(){
        emailTextField.addTarget(self, action: #selector(handleTextChanged(sender:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextChanged(sender:)), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(handleTextChanged(sender: )), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(handleTextChanged(sender: )), for: .editingChanged)
    }
    
    @objc func handleAlreadyHaveAccountButton(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleAddPhotoButton(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @objc func handleSignUp(){
        print("Signing up")
    }
    
    @objc func handleTextChanged(sender: UITextField){
        switch sender {
        case emailTextField:
            viewModel.email = sender.text
        case passwordTextField:
            viewModel.password = sender.text
        case usernameTextField:
            viewModel.username = sender.text
        case fullNameTextField:
            viewModel.fullname = sender.text
        default:
            print("Please enter all the fields")
        }
        updateForm()
    }
    
    func updateForm(){
        signUpButton.isEnabled = viewModel.formIsValid
        signUpButton.backgroundColor = viewModel.backgroundColor
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    }
}

//MARK: - UIImagePicker Delegate methods

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else {return}
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.width / 2
        addPhotoButton.layer.masksToBounds = true
        addPhotoButton.layer.borderColor = UIColor.black.cgColor
        addPhotoButton.layer.borderWidth = 2
        addPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
    }
}
