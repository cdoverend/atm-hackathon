//
//  ViewController.swift
//  ATMHackathonApp
//
//  Created by Overend, Christopher on 5/10/17.
//  Copyright © 2017 Capital One. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager = CLLocationManager.init()
    var userLocation: CLLocation = CLLocation.init()
    var branches = [Dictionary<String, Any>]()
    
    var branch1: Dictionary<String, Any> = ["location": CLLocation(latitude: 38.925970, longitude: -77.212138),
                                            "name": "branch1",
                                            "atms": ["ATM1", "ATM2"]]
    
    var branch2: Dictionary<String, Any> = ["location": CLLocation(latitude: 38.925970, longitude: -77.212138),
                                            "name": "branch2",
                                            "atms": ["ATM3", "ATM4"]]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.branches.append(branch1)
        self.branches.append(branch2)
        
        
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkForBranch() -> Dictionary<String, Any>
    {
        for branch in branches
        {
            let branchCoordinates: CLLocation = branch["location"] as! CLLocation
            if self.userLocation.distance(from: branchCoordinates) < 20.0
            {
                // Youre in the branch!!
                return branch
            }
        }
        return [String:Any]()
        
    }
    
    /*** LocationManager***/
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0
        {
            let newLocation: CLLocation = locations.first!
            if didUserLocationChange(newLocation: newLocation)
            {
                // check if entering a branch
                let currentBranch = checkForBranch()
                if !currentBranch.isEmpty
                {
                    // Subscribe and things
                }
            }
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func didUserLocationChange(newLocation: CLLocation) -> Bool
    {
        let distanceChange: CLLocationDistance = newLocation.distance(from: newLocation)
        
        guard distanceChange > 10.0 else {
            return false
        }
        
        self.userLocation = newLocation
        
        return true
    }



}

