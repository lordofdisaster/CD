//
//  EditDetailCarLocationViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 6/1/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class EditDetailCarLocationViewController: CardeeViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var mapView = GMSMapView()
    var carLocationView: CarLocationView!
    var hideExactLocationView: HideExactLocationView!
    
    var carLocation = CarLocation()
    
    //MARK: Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Car Location"
        
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
        currentLocationButton.setImage(#imageLiteral(resourceName: "current_location"), for: .normal)
        currentLocationButton.imageEdgeInsets = UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 13)
        self.view.addSubview(currentLocationButton)
        
        // Init map pin
        
        let pinView = UIView(frame: CGRect(x: self.mapView.center.x - 19.5, y: self.mapView.center.y - 19.5, width: 40, height: 40))
        pinView.backgroundColor = UIColor.white
        pinView.layer.cornerRadius = 20
        pinView.layer.borderColor = Color.darkBlue.cgColor
        pinView.layer.borderWidth = 1
        
        let pinImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        pinImageView.image = #imageLiteral(resourceName: "car_location")
        pinImageView.contentMode = .scaleAspectFit
        
        pinView.addSubview(pinImageView)
        
        self.mapView.addSubview(pinView)
        
        // Init location manager
        
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.saveInfo))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "close"), style: .plain, target: self, action: #selector(self.goBack))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NewCar.shared.carLocation = self.carLocation
    }
    
    //MARK: Actions
    
    func setDefaultSelection() {
        if let carLocation = NewCar.shared.carLocation {
            self.carLocation = carLocation
            let camera = GMSCameraPosition.camera(withLatitude: (self.carLocation.carLocationCoordinate!.latitude), longitude:(self.carLocation.carLocationCoordinate!.longitude), zoom: 14)
            mapView.animate(to: camera)
            self.reverseGeocodeCoordinate(coordinate: self.carLocation.carLocationCoordinate!)
        }
    }
    
    //MARK: Navigation Actions
    
    func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveInfo() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func moveMapToCurrentLocation() {
        let location = mapView.myLocation
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude:(location?.coordinate.longitude)!, zoom: 17)
        self.mapView.animate(to: camera)
    }
    
    // Transform coord to name
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        self.carLocation.carLocationCoordinate = coordinate
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
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude:(location?.coordinate.longitude)!, zoom: 17)
        mapView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
        self.setDefaultSelection()
    }}
