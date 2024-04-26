//
//  ChatMapVC.swift
//  RelayMessenger
//
//  Created by JJ on 27/04/24.
//

import UIKit
import GoogleMaps

protocol ChatMapVCDelegate: AnyObject{
    func didTapLocation(lat: String,long: String)
}

class ChatMapVC: UIViewController{
    //MARK: - properties
    weak var delegate: ChatMapVCDelegate?
    private let mapView = GMSMapView()
    private var location: CLLocationCoordinate2D?
    private lazy var marker = GMSMarker()
    
    private lazy var sendLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send Location", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .red
        button.setDimensions(height: 50, width: 150)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSendLocationButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureMapView()
    }
    
    //MARK: - helpers
    private func configureUI(){
        title = "Select location"
        view.addSubview(mapView)
        view.backgroundColor = .white
        mapView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor)
        
        view.addSubview(sendLocationButton)
        sendLocationButton.centerX(inView: view)
        sendLocationButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20)
    }
    
    private func configureMapView(){
        FLocationManager.shared.start { info in
            self.location = CLLocationCoordinate2D(latitude: info.latitude ?? 0.0, longitude: info.longitude ?? 0.0)
            self.mapView.delegate = self
            self.mapView.isMyLocationEnabled = true
            self.mapView.settings.myLocationButton = true
            guard let location = self.location else {return}
            self.updateCamera(location: location)
            FLocationManager.shared.stop()
        }
        
    }
    
    func updateCamera(location: CLLocationCoordinate2D){
        self.location = location
        self.mapView.camera = GMSCameraPosition(target: location, zoom: 15)
        self.mapView.animate(toLocation: location)
        
        //Add marker
        marker.map = nil
        marker = GMSMarker(position: location)
        marker.map = mapView
    }
    
    @objc func handleSendLocationButton(){
        guard let lat = location?.latitude else {return}
        guard let long = location?.longitude else {return}
        delegate?.didTapLocation(lat: "\(lat)", long: "\(long)")
    }
    
}

//MARK: - GMSMapViewDelegate
extension ChatMapVC: GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        updateCamera(location: coordinate)
    }
}
