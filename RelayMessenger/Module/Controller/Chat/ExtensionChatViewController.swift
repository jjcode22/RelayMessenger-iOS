//
//  ExtensionChatViewController.swift
//  RelayMessenger
//
//  Created by JJ on 31/03/24.
//

import UIKit
import SDWebImage
import ImageSlideshow

//MARK: -  Handle Camera and Gallery attachments

extension ChatViewController{
    @objc func handleCamera(){
        imagePicker.sourceType = .camera
        imagePicker.mediaTypes = ["public.image","public.movie"]
        present(imagePicker, animated: true)
        print("Camera")
    }
    
    @objc func handleGallery(){
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.mediaTypes = ["public.image","public.movie"]
        present(imagePicker, animated: true)
        print("Gallery")
    }
    
    
}

//MARK: - UIImagePickerControllerDelegate
extension ChatViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //getting the mediaType
        dismiss(animated: true) {
            guard let mediaType = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.mediaType.rawValue)] as? String else {return}
            print("mediaType: \(mediaType)")
            
            if mediaType == "public.image"{
                //upload image
                guard let image = info[.editedImage] as? UIImage else {return}
                self.uploadImage(withImage: image)
            }else{
                guard let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL else{return}
                self.uploadVideo(withVideoURL: videoURL)
                
            }
        }
    }
    
}

//MARK: - Upload media

extension ChatViewController{
    func uploadImage(withImage image: UIImage){
        showLoader(true)
        FileUploader.uploadImage(image: image) { [self] imageURL in
            MessageServices.fetchSingleRecentMessage(otherUser: otherUser) { unReadCount in
                MessageServices.uploadMessage(imageURL: imageURL, currentUser: self.currentUser, otherUser: self.otherUser, unReadCount: unReadCount + 1) { error in
                    self.showLoader(false)
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                        return
                    }
                }
            }
        }
    }
    
    func uploadVideo(withVideoURL url: URL){
        showLoader(true)
        FileUploader.uploadVideo(url: url) { videoURL in
            MessageServices.fetchSingleRecentMessage(otherUser: self.otherUser) { unReadCount in
                MessageServices.uploadMessage(videoURL: videoURL,currentUser: self.currentUser, otherUser: self.otherUser, unReadCount: unReadCount + 1) { error in
                    self.showLoader(false)
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                        return
                    }

                }
            }
        } failure: { error in
            print("Error:\(error.localizedDescription)")
            return
        }

        
    }
}

//MARK: - ChatCellDelegate - for playing video

extension ChatViewController: ChatCellDelegate,ImageSlideshowDelegate {
    func cell(wantsToPlayVideo cell: ChatCell, videoURL: URL?) {
        guard let videoURL = videoURL else {return}
        let controller = VideoPlayerViewController(videoURL: videoURL)
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func cell(wantsToShowImage cell: ChatCell, imageURL: URL?) {
        let slideShow = ImageSlideshow()
        guard let imageURL = imageURL else {return}
        SDWebImageManager.shared().loadImage(with: imageURL, progress: nil){image,_,_,_,_,_ in
            guard let image = image else {return}
            slideShow.setImageInputs([
                ImageSource(image: image)
            ])
            slideShow.delegate = self
            let controller = slideShow.presentFullScreenController(from: self)
            controller.slideshow.activityIndicator = DefaultActivityIndicator()
        }
        
    }
}
