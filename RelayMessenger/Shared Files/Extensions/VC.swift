//
//  VC.swift
//  RelayMessenger
//
//  Created by JJ on 21/03/24.
//

import UIKit
import JGProgressHUD
import SDWebImage

extension UIViewController{
    static let hud = JGProgressHUD(style: .dark)
    
    func showLoader(_ show: Bool){
        view.endEditing(true)
        
        if show{
            UIViewController.hud.show(in: view)
        }else {
            UIViewController.hud.dismiss()
        }
    }
    
    func showMessage(title: String, message: String, completion: (() -> Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            completion?()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
    //Download image from google account and save it into esacping completion handler closure asynchronously
    func getImage(withImageURL imageURL: URL, completion: @escaping(UIImage) -> Void){
        SDWebImageManager.shared().loadImage(with: imageURL,options: .continueInBackground, progress: nil){ image,data,error,cashType,finished,url in
            if let error = error{
                self.showMessage(title: "Error:", message: error.localizedDescription)
                return
            }
            guard let image = image else {return}
            completion(image)
            
        }
    }
    
    func stringValue(forDate date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    
    
}
