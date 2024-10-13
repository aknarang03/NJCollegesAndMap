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
    
    var collegeAnnotations: [CollegeAnnotation] = []
    
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
            
            let logoString = collegesModel.getImage(collegeName: college.name)
            
            let annotation = CollegeAnnotation(latitude: college.coordinates[1], longitude: college.coordinates[0], title: college.name, logoString: logoString, id: college.id)
            
            collegeAnnotations.append(annotation)
            
        }
        
        map.addAnnotations(collegeAnnotations)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print ("Error: \(error)")
    }
    
    // annotation view
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let collegeAnnotation = annotation as? CollegeAnnotation
        
        let identifier = "CollegeAnnotation"
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        
        annotationView.image = UIImage(named: collegeAnnotation?.logoString! ?? "default_uni")
        annotationView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        annotationView.canShowCallout = true
        annotationView.calloutOffset = CGPoint(x: -5.0, y: 5.0)
        
        //        let imageView = UIImageView (frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 60.0, height: 60.0)))
        //        imageView.image = UIImage(named: collegeAnnotation?.logoString! ?? "default_uni")
        
        let detailButton = UIButton(type: .detailDisclosure)
        annotationView.rightCalloutAccessoryView = detailButton
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == annotationView.rightCalloutAccessoryView {
            let collegeAnnotation = annotationView.annotation as! CollegeAnnotation
            performSegue(withIdentifier: "showDetailFromMap", sender: collegeAnnotation)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailFromMap" {
            if let destinationViewController = segue.destination as? CollegeDetailViewController, let collegeAnnotation = sender as? CollegeAnnotation {
                destinationViewController.showCollegeId = collegeAnnotation.id
            }
        }
    }
    
}
