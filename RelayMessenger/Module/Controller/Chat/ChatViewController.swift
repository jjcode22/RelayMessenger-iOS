//
//  ChatViewController.swift
//  RelayMessenger
//
//  Created by JJ on 22/03/24.
//
import Foundation
import UIKit

class ChatViewController: UICollectionViewController {
    //MARK: - properties
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    //MARK: - helpers
    
}

extension ChatViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
