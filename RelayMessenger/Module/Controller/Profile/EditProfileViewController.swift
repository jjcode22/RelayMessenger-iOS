//
//  EditProfileViewController.swift
//  RelayMessenger
//
//  Created by JJ on 27/04/24.
//

import UIKit

class EditProfileViewController: UIViewController{
    //MARK: - properties
    private var user: User
    
    private lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.tintColor = .white
        button.backgroundColor = .lightGray
        button.setDimensions(height: 40, width: 140)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSubmitButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var profileImageView:CustomImageView = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
        let iv = CustomImageView(width: 125,backgroundColor: .lightGray, height: 125,cornerRadius: 125/2)
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    
    
    private let fullNameLabel = CustomLabel(text: "Fullname",labelColor: .red)
    private let userNameLabel = CustomLabel(text: "Username",labelColor: .red)
    
    
    private lazy var fullNameTextField = CustomTextField(placeholder: "Fullname")
    
    private lazy var userNameTextField = CustomTextField(placeholder: "Username")
    
    private lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        return picker
    }()
    
    var selectedImage: UIImage?
    
    
    //MARK: - lifecycle
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureProfileData()
    }
    
    
    //MARK: - helpers
    
    func configureUI(){
        view.backgroundColor = .white
        
        title = "Edit Profile"
        
        view.addSubview(submitButton)
        submitButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,right: view.rightAnchor,paddingRight: 12)
        
        view.addSubview(profileImageView)
        profileImageView.centerX(inView: view,topAnchor: submitButton.bottomAnchor,paddingTop: 10)
        
        let stackView = UIStackView(arrangedSubviews: [fullNameLabel,fullNameTextField,userNameLabel,userNameTextField])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        view.addSubview(stackView)
        stackView.anchor(top: profileImageView.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 20,paddingLeft: 30,paddingRight: 30)
        

        fullNameTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1).isActive = true
        userNameTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1).isActive = true
        
        
    }
    
    func configureProfileData(){
        fullNameTextField.text = user.fullname
        userNameTextField.text = user.username
        
        profileImageView.sd_setImage(with: URL(string: user.profileImage))
    }
    
    
    @objc func handleSubmitButton(){
        guard let fullname = fullNameTextField.text else {return}
        guard let username = userNameTextField.text else {return}
        
        showLoader(true)
        if selectedImage == nil{
            //Update the user profile data without the Image
            let param = [
                "fullname": fullname,
                "username": username
            ]
            UserServices.updateUserData(data: param) { _ in
                //
                self.showLoader(false)
            }
        }else{
            //Update user data w image
            guard let selectedImage = selectedImage else {return}
            FileUploader.uploadImage(image: selectedImage) { imageURL in
                let param = [
                    "fullname": fullname,
                    "username": username,
                    "profileImageURL": imageURL
                ]
                UserServices.updateUserData(data: param) { _ in
                    //
                    self.showLoader(false)
                }
            }
            
        }
    }
    
    @objc func handleImageTap(){
        present(imagePicker, animated: true)
    }
}

//MARK: - UIImagePickerControllerDelegate
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //
        guard let image = info[.editedImage] as? UIImage else {return}
        self.selectedImage = image
        self.profileImageView.image = image
        
        dismiss(animated: true)
    }
}
