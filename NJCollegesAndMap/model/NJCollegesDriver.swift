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
        
        print("\nSize: \(colleges.count)")
        
        print("\nAll Names:")
        for college in colleges {
            print(college.name)
        }
        
        let monmouthUniversity = colleges[35]
        print("\nMonmouth University Details:")
        print("ID: \(monmouthUniversity.id)")
        print("Name: \(monmouthUniversity.name)")
        print("City: \(monmouthUniversity.city)")
        print("County: \(monmouthUniversity.county)")
        print("Coordinates: \(monmouthUniversity.coordinates)")
        
    }
    
}
