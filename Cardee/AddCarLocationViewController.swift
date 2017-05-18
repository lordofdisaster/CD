//
//  AddCarLocationViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/7/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class AddCarLocationViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var mapView = GMSMapView()
    var carLocationView: CarLocationView!
    var hideExactLocationView: HideExactLocationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Car Location"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
        
        // Init map
        
        self.mapView = GMSMapView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: self.view.frame.height - 62 - CGFloat(System.navigationBarHeight) - CGFloat(System.statusBarHeight)))
        self.mapView.isMyLocationEnabled = true
        self.mapView.delegate = self
        
        self.view.addSubview(self.mapView)
        
        // Init cat location view
        
        self.carLocationView = CarLocationView(frame: CGRect(x: 13, y: 13, width: Screen.width - 26, height: 63))
        self.view.addSubview(self.carLocationView)
        
        // Init hide location view
        
        self.hideExactLocationView = HideExactLocationView(frame: CGRect(x: 0, y: self.view.frame.height - 62 - CGFloat(System.navigationBarHeight) - CGFloat(System.statusBarHeight), width: Screen.width, height: 62))
        self.view.addSubview(self.hideExactLocationView)
        
        // Current location button
        
        let currentLocationButton = UIButton(type: .system)
        currentLocationButton.frame = CGRect(x: Screen.width - 48 - 13, y: self.carLocationView.frame.origin.y + self.carLocationView.frame.height + 10, width: 48, height: 48)
        currentLocationButton.layer.cornerRadius = 24
        currentLocationButton.backgroundColor = UIColor.white
        currentLocationButton.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.24).cgColor
        currentLocationButton.layer.shadowRadius = 5
        currentLocationButton.layer.shadowOpacity = 0.5
        currentLocationButton.addTarget(self, action: #selector(moveMapToCurrentLocation), for: .touchUpInside)
        self.view.addSubview(currentLocationButton)
        
        // Init map pin
        
        let pinImageView = UIImageView(frame: CGRect(origin: CGPoint(x: self.mapView.center.x - 19.5, y: self.mapView.center.y - 19.5), size: CGSize(width: 39.0, height: 39.0)))
        pinImageView.backgroundColor = UIColor.white
        pinImageView.layer.cornerRadius = 19.5
        pinImageView.layer.borderColor = Color.darkBlue.cgColor
        pinImageView.layer.borderWidth = 1
        self.mapView.addSubview(pinImageView)
        
        // Init location manager
        
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        // Init next button
        
        let nextButton = NextButtonObject()
        nextButton.addButton(on: self.view)
        var newFrame = nextButton.backView.frame
        newFrame.origin.y -= 62
        nextButton.backView.frame = newFrame
    }

    func save() {
        print("Save")
    }
    
    func moveMapToCurrentLocation() {
        let location = mapView.myLocation
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude:(location?.coordinate.longitude)!, zoom: 14)
        self.mapView.animate(to: camera)
    }
    // Transform coord to name
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        print(coordinate)
        self.carLocationView.addressLabel.text = "Loading..."
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                let lines = address.lines!
                self.carLocationView.addressLabel.text = lines.joined(separator: "\n")
                UIView.animate(withDuration: 0.25) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    //MARK: Memory Warning
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(coordinate: position.target)
    }
    
    // Get location
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude:(location?.coordinate.longitude)!, zoom: 14)
        mapView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
    }
}
