//
//  CustomImageView.swift
//  RelayMessenger
//
//  Created by JJ on 14/03/24.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {
    init(image: UIImage? = nil, width: CGFloat? = nil,backgroundColor: UIColor? = nil ,height: CGFloat? = nil, cornerRadius: CGFloat = 0){
        super.init(frame: .zero)
        contentMode = .scaleAspectFit
        layer.cornerRadius = cornerRadius
        
        if let image = image{
            self.image = image
        }
        if let width = width{
            setWidth(width)
        }
        if let height = height{
            setHeight(height)
        }
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
