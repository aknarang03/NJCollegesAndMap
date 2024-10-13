//
//  CollegeAnnotation.swift
//  NJCollegesAndMap
//
//  Created by Anjali Narang  on 10/12/24.
//

import Foundation
import MapKit
import Contacts

class CollegeAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var logoString: String?
    var id: Int
    
    init (latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String, logoString: String, id: Int) {
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.title = title
        self.logoString = logoString
        self.id = id
    }
    
    func mapItem() -> MKMapItem {
        let destinationTitle = title!
        let addrDict = [CNPostalAddressCityKey: destinationTitle]
        let placemark = MKPlacemark (coordinate: coordinate, addressDictionary: addrDict)
        let mapItem = MKMapItem (placemark: placemark)
        return mapItem
    }
}
