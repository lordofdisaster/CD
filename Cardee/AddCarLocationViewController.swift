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
    
    var carLocation = CarLocation()
    
    //MARK: Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Car Location"
        
        
        
        initMap()
        initAddressFieldInfo()
        initFooterHideExactLocationView()
        initCurrentLocationButton()
        initCarPinView()
        
        // Init location manager
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(self.goToNextStep))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron_left"), style: .plain, target: self, action: #selector(self.goToParent))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NewCar.shared.carLocation = self.carLocation
    }
    
    //MARK: Actions
    
    func changeHideExactLocationValue(_ sender: UISwitch) {
        self.carLocation.isExactLocationHidden = sender.isOn
    }
    
    func setDefaultSelection() {
        if let carLocation = NewCar.shared.carLocation {
            self.carLocation = carLocation
            if let isExactLocationHidden = self.carLocation.isExactLocationHidden {
                self.hideExactLocationView.hideExactLocationSwitch.isOn = isExactLocationHidden
            } else {
                self.carLocation.isExactLocationHidden = false
            }
            let camera = GMSCameraPosition.camera(withLatitude: (self.carLocation.carLocationCoordinate!.latitude), longitude:(self.carLocation.carLocationCoordinate!.longitude), zoom: 17)
            mapView.animate(to: camera)
            self.reverseGeocodeCoordinate(coordinate: self.carLocation.carLocationCoordinate!)
        } else {
            self.carLocation.isExactLocationHidden = false
        }
    }
    
    //MARK: Navigation Actions
    
    func goToParent() {
        let vc = self.navigationController?.viewControllers[1] as! AddCarViewController
        self.navigationController?.popToViewController(vc, animated: true)
    }

    func goToNextStep() {
        self.performSegue(withIdentifier: "nextSegue", sender: self)
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
        self.carLocationView.addressTextField.text = "Loading..."
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                let lines = address.lines!
                self.carLocationView.addressTextField.text = lines.joined(separator: "\n")
                self.carLocation.address = lines[0]
                self.carLocation.town = lines[1]
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
    }
}


// UI
extension AddCarLocationViewController {
    func initMap() {
        self.mapView = GMSMapView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: self.view.frame.height - 62 - CGFloat(System.navigationBarHeight) - CGFloat(System.statusBarHeight)))
        self.mapView.isMyLocationEnabled = true
        self.mapView.delegate = self
        
        self.view.addSubview(self.mapView)
        
    }
    
    func initAddressFieldInfo() {
        // Init cat location view
        self.carLocationView = CarLocationView(frame: CGRect(x: 13, y: 13, width: Screen.width - 26, height: 63))
        self.view.addSubview(self.carLocationView)
        
    }
    
    
    func initFooterHideExactLocationView() {
        // Init hide location view
        
        self.hideExactLocationView = HideExactLocationView(frame: CGRect(x: 0, y: self.view.frame.height - 62 - CGFloat(System.navigationBarHeight) - CGFloat(System.statusBarHeight), width: Screen.width, height: 62))
        self.hideExactLocationView.hideExactLocationSwitch.addTarget(self, action: #selector(self.changeHideExactLocationValue(_:)), for: .valueChanged)
        self.view.addSubview(self.hideExactLocationView)
        
    }
    
    func initCurrentLocationButton() {
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
        
    }
    
    
    func initCarPinView() {
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
        
    }
    
}
