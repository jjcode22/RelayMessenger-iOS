//
//  VideoPlayerVIewController.swift
//  RelayMessenger
//
//  Created by JJ on 04/04/24.
//

import Foundation
import AVKit

class VideoPlayerVIewController: AVPlayerViewController {
    private var videoURL: URL
    
    init(videoURL: URL) {
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Video Player"
        view.backgroundColor = .systemGray6
        player = AVPlayer(url: videoURL)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if isMovingFromParent {
            try? FileManager.default.removeItem(at: videoURL)
        }
    }
}
