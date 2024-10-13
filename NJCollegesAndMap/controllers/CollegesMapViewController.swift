//
//  CollegesMapViewController.swift
//  NJCollegesAndMap
//
//  Created by Anjali Narang  on 10/12/24.
//

import UIKit
import MapKit

class CollegesMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let collegesModel = NJCollegesModel.sharedInstance
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var map: MKMapView!
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        map.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        map.showsUserLocation = true
        
        zoomToNewJersey()
        addColleges()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    func zoomToNewJersey() { // NJ: 40.0583° N, 74.4057° W
        let njCenter = CLLocationCoordinate2D(latitude: 40.0583, longitude: -74.4057)
        let region = MKCoordinateRegion(center: njCenter, latitudinalMeters: 250000, longitudinalMeters: 250000)
        map.setRegion(region, animated: true)
    }
    
    func addColleges() {
        
        for college in collegesModel.njColleges {
            let annotation = MKPointAnnotation()
            annotation.title = college.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: college.coordinates[1], longitude: college.coordinates[0])
            map.addAnnotation(annotation)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print ("Error: \(error)")
    }

}


