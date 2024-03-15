//
//  FileUploader.swift
//  RelayMessenger
//
//  Created by JJ on 14/03/24.
//

import Foundation
import UIKit
import FirebaseAuth

struct FileUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void){
        guard let imageData = image.jpegData(withCompressionQuality: 0.75) else {return}
        let uid = Auth.auth().currentUser?.uid
        
    }
    
}
