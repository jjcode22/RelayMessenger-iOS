//
//  Buttons.swift
//  RelayMessenger
//
//  Created by JJ on 14/03/24.
//

import UIKit

extension UIButton{
    func attributedText(firstString: String,secondString: String){
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.6), .font: UIFont.systemFont(ofSize: 16)]
        
        let attributedTitle = NSMutableAttributedString(string: "\(firstString) ", attributes: atts)
        
        let secondAtts: [NSAttributedString.Key: Any] = [.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.9), .font: UIFont.boldSystemFont(ofSize: 16)]
        
        attributedTitle.append(NSAttributedString(string: secondString, attributes: secondAtts))
        
        setAttributedTitle(attributedTitle, for: .normal)
        
    }
    
    func primaryButton(buttonText: String){
        setTitle(buttonText, for: .normal)
        setHeight(50)
        layer.cornerRadius = 10
        backgroundColor = #colorLiteral(red: 0, green: 0.0745, blue: 0.5176, alpha: 1).withAlphaComponent(0.5)
        isEnabled = false
        tintColor = .white
        titleLabel?.font = .boldSystemFont(ofSize: 18)
        
    }
}
