//
//  CollegesMapViewController.swift
//  NJCollegesAndMap
//
//  Created by Anjali Narang  on 10/12/24.
//

import UIKit
import MapKit

class CollegesMapViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        zoomToNewJersey()
    }
    
    func zoomToNewJersey() { // NJ: 40.0583° N, 74.4057° W
        let njCenter = CLLocationCoordinate2D(latitude: 40.0583, longitude: -74.4057)
        let region = MKCoordinateRegion(center: njCenter, latitudinalMeters: 250000, longitudinalMeters: 250000)
        map.setRegion(region, animated: true)
    }

}


