//
//  NJCollegesModel.swift
//  NJCollegesAndMap
//
//  Created by Anjali Narang  on 10/12/24.
//

import Foundation

struct College: Codable {
    var coordinates: [Double]
    var id: Int
    var name: String
    var city: String
    var county: String
}

class NJCollegesModel {
    
    var njColleges: [College] = []
    static let sharedInstance = NJCollegesModel()
        
    private init () {
        readCollegesData()
    }
    
    func getColleges() -> [College] {
        return self.njColleges
    }
    
    func readCollegesData() {
        
        if let filename = Bundle.main.path(forResource: "NJColleges", ofType: "json") {
            
            do {
                
                let jsonStr  = try String (contentsOfFile: filename, encoding: .utf8)
                let jsonData = jsonStr.data(using: .utf8)!
                
                // decode features (top level object)
                let features = try! JSONDecoder().decode([Feature].self, from: jsonData)
                
                for feature in features {
                    
                    // create college from featue
                    
                    let currentCollege = College(
                        coordinates: feature.geometry.coordinates,
                        id: feature.id,
                        name: feature.properties.name,
                        city: feature.properties.city,
                        county: feature.properties.county
                    )
                    
                    self.njColleges.append(currentCollege) // add to list
                    
                }
                
            }
            
            catch { print("The file could not be loaded") }
            
        }
        
        else { print ("The file could not be found") }
        
    }
    
}
