//
//  NJCollegesDriver.swift
//  NJCollegesAndMap
//
//  Created by Anjali Narang  on 10/12/24.
//

import Foundation

func testModel() {

    let collegesModel = NJCollegesModel.sharedInstance
    let colleges = collegesModel.getColleges()
    
    if colleges.isEmpty { print("Load unsuccessful.") }
    
    else {
        
        print("Load successful.")
        
        if let firstCollege = colleges.first {
            print("\nFirst College Details:")
            print("ID: \(firstCollege.id)")
            print("Name: \(firstCollege.name)")
            print("City: \(firstCollege.city)")
            print("County: \(firstCollege.county)")
            print("Coordinates: \(firstCollege.coordinates)")
        }
        
    }
    
}
