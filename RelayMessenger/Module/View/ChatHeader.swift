//
//  ChatHeader.swift
//  RelayMessenger
//
//  Created by JJ on 31/03/24.
//

import UIKit

class ChatHeader: UICollectionReusableView {
    //MARK: - Properties
    var dateValue: String?{
        didSet{
            configure()
        }
    }
    
    private let dateLabel: CustomLabel = {
        let label = CustomLabel(text: "04/06/2024",textFont: .boldSystemFont(ofSize: 16),labelColor: .white)
        label.backgroundColor = .black.withAlphaComponent(0.5)
        label.setDimensions(height: 30, width: 100)
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        return label
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(dateLabel)
        dateLabel.center(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    private func configure(){
        guard let dateValue = dateValue else {return}
        dateLabel.text = dateValue
    }
}
