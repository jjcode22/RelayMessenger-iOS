//
//  CustomTextField.swift
//  RelayMessenger
//
//  Created by JJ on 14/03/24.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    init(placeholder: String, keyboardType: UIKeyboardType = .default, isSecureText: Bool = false){
        super.init(frame: .zero)
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        
        borderStyle = .none
        textColor = .black
        keyboardAppearance = .light
        backgroundColor = #colorLiteral(red: 0.9341318189, green: 0.9341318189, blue: 0.9341318189, alpha: 1)
        clearButtonMode = .whileEditing
        layer.cornerRadius = 5
        setHeight(50)
        self.placeholder = placeholder

        self.keyboardType = keyboardType
        isSecureTextEntry = isSecureText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
