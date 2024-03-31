//
//  ExtensionChatViewController.swift
//  RelayMessenger
//
//  Created by JJ on 31/03/24.
//

import UIKit
//MARK: -  Handle Camera and Gallery attachments

extension ChatViewController{
    @objc func handleCamera(){
        imagePicker.sourceType = .camera
        imagePicker.mediaTypes = ["public.image"]
        present(imagePicker, animated: true)
        print("Camera")
    }
    
    @objc func handleGallery(){
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.mediaTypes = ["public.image"]
        present(imagePicker, animated: true)
        print("Gallery")
    }
}

//MARK: - UIImagePickerControllerDelegate
extension ChatViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //
    }
    
}
