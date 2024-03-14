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
}
